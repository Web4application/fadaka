// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Minimal ERC20 using OpenZeppelin style: mint on deploy to deployer
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract FadakaToken is IERC20 {
    string public name;
    string public symbol;
    uint8  public constant decimals = 18;
    uint256 private _totalSupply;
    address public owner;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 initialSupply // expected in whole tokens (will be multiplied by 10**decimals)
    ) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;

        uint256 supplyWithDecimals = initialSupply * (10 ** decimals);
        _mint(owner, supplyWithDecimals);
    }

    function totalSupply() external view override returns (uint256) { return _totalSupply; }
    function balanceOf(address account) external view override returns (uint256) { return _balances[account]; }

    function transfer(address to, uint256 amount) external override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address holder, address spender) external view override returns (uint256) {
        return _allowances[holder][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external override returns (bool) {
        uint256 allowed = _allowances[from][msg.sender];
        require(allowed >= amount, "Allowance exceeded");
        _allowances[from][msg.sender] = allowed - amount;
        _transfer(from, to, amount);
        return true;
    }

    // ============ internal =============
    function _transfer(address from, address to, uint256 amount) internal {
        require(to != address(0), "zero address");
        uint256 bal = _balances[from];
        require(bal >= amount, "Insufficient balance");
        _balances[from] = bal - amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "zero address");
        _totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    // Optional owner-only burn (handy for token control)
    function burn(uint256 amount) external onlyOwner {
        require(_balances[owner] >= amount, "Insufficient");
        _balances[owner] -= amount;
        _totalSupply -= amount;
        emit Transfer(owner, address(0), amount);
    }
}
