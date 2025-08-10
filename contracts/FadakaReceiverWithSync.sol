// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract FadakaReceiverWithSync {
    address public owner;
    address public immutable fadakaToken;

    // track last observed balances so we can detect new transfers
    mapping(address => uint256) public lastBalance;

    event EtherReceived(address indexed from, uint256 amount);
    event ERC20Received(address indexed token, address indexed from, uint256 amount);
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // simple reentrancy guard
    uint256 private _unlocked = 1;
    modifier nonReentrant() {
        require(_unlocked == 1, "Reentrancy");
        _unlocked = 0;
        _;
        _unlocked = 1;
    }

    constructor(address _fadakaToken) payable {
        require(_fadakaToken != address(0), "Invalid token");
        owner = msg.sender;
        fadakaToken = _fadakaToken;

        // initialize lastBalance for Fadaka and ETH
        lastBalance[_fadakaToken] = IERC20(_fadakaToken).balanceOf(address(this));
    }

    // Accept ETH directly
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // ERC-677/1363 style callback (only from Fadaka token if used)
    function onTokenTransfer(address from, uint256 amount, bytes calldata) external returns (bool) {
        require(msg.sender == fadakaToken, "Only Fadaka token allowed");
        // update lastBalance to reflect this incoming amount
        lastBalance[msg.sender] += amount;
        emit ERC20Received(msg.sender, from, amount);
        return true;
    }

    // === Sync methods for regular ERC-20 transfers ===
    // Anyone (relayer or sender) can call this after transferring tokens to this contract.
    // It compares current balance to last recorded balance and emits event for the difference.
    function syncToken(address token) external nonReentrant returns (uint256 newAmount) {
        uint256 current = IERC20(token).balanceOf(address(this));
        uint256 last = lastBalance[token];
        require(current > last, "No new tokens to sync");
        newAmount = current - last;
        lastBalance[token] = current;

        // caller may be a relayer; we use msg.sender as the "from" in the event.
        emit ERC20Received(token, msg.sender, newAmount);
    }

    // Convenience: sync the Fadaka token specifically
    function syncFadaka() external nonReentrant returns (uint256 newAmount) {
        return syncToken(fadakaToken);
    }

    // View helpers
    function ethBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function tokenBalance(address token) public view returns (uint256) {
        return IERC20(token).balanceOf(address(this));
    }

    // Owner controls
    function withdrawEther(address payable to, uint256 amount) public onlyOwner nonReentrant {
        require(address(this).balance >= amount, "Insufficient ETH");
        to.transfer(amount);
    }

    function withdrawERC20(address token, address to, uint256 amount) public onlyOwner nonReentrant {
        require(IERC20(token).transfer(to, amount), "ERC20 transfer failed");
        // update lastBalance to reflect withdrawal so future syncs don't emit false positives
        lastBalance[token] = IERC20(token).balanceOf(address(this));
    }

    function changeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "zero addr");
        emit OwnerChanged(owner, newOwner);
        owner = newOwner;
    }
} 
