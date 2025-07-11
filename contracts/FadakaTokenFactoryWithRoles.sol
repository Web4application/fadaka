// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract FadakaTokenFactoryWithRoles is ERC1155, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    bytes32 public constant ADMIN_ROLE = DEFAULT_ADMIN_ROLE;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    struct TokenMeta {
        string name;
        string uri;
        address creator;
        uint256 totalMinted;
    }
    mapping(uint256 => TokenMeta) public tokenMeta;

    constructor(string memory baseURI, address admin) ERC1155(baseURI) {
        _grantRole(ADMIN_ROLE, admin);
        _grantRole(MINTER_ROLE, admin);
    }

    function mintNewType(address to, uint256 amount, string memory name, string memory tokenURI, bytes memory data)
        public onlyRole(MINTER_ROLE) returns (uint256)
    {
        _tokenIdCounter.increment();
        uint256 newTokenId = _tokenIdCounter.current();

        tokenMeta[newTokenId] = TokenMeta(name, tokenURI, msg.sender, amount);
        _mint(to, newTokenId, amount, data);
        emit URI(tokenURI, newTokenId);
        return newTokenId;
    }

    function mintExisting(address to, uint256 id, uint256 amount, bytes memory data)
        public onlyRole(MINTER_ROLE)
    {
        require(bytes(tokenMeta[id].name).length > 0, "Token ID not created");
        tokenMeta[id].totalMinted += amount;
        _mint(to, id, amount, data);
    }

    function grantMinter(address account) external onlyRole(ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, account);
    }

    function revokeMinter(address account) external onlyRole(ADMIN_ROLE) {
        _revokeRole(MINTER_ROLE, account);
    }

    function getTokenDetails(uint256 id) external view returns (TokenMeta memory) {
        return tokenMeta[id];
    }
}
