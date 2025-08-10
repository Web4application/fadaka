// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IFadaka {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract FadakaReceiver {
    address public owner;
    address public immutable fadakaToken;

    event EtherReceived(address indexed from, uint256 amount);
    event FadakaReceived(address indexed from, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _fadakaToken) payable {
        require(_fadakaToken != address(0), "Invalid token");
        owner = msg.sender;
        fadakaToken = _fadakaToken;
    }

    // Accept ETH directly
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // ERC-677 / ERC-1363 style callback (only from Fadaka token)
    function onTokenTransfer(address from, uint256 amount, bytes calldata) external returns (bool) {
        require(msg.sender == fadakaToken, "Only Fadaka token allowed");
        emit FadakaReceived(from, amount);
        return true;
    }

    // View balances
    function ethBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function fadakaBalance() public view returns (uint256) {
        return IFadaka(fadakaToken).balanceOf(address(this));
    }

    // Withdraw functions
    function withdrawEther(address payable to, uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Insufficient ETH");
        to.transfer(amount);
    }

    function withdrawFadaka(address to, uint256 amount) public onlyOwner {
        require(IFadaka(fadakaToken).transfer(to, amount), "Token transfer failed");
    }
}
