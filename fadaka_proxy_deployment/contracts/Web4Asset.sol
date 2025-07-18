// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Web4Asset is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    string private _baseTokenURI;

    constructor(string memory baseURI_) ERC721("Web4Asset", "W4A") {
        _baseTokenURI = baseURI_;
    }

    function mint(address to, string memory tokenURI_) external onlyOwner returns (uint256) {
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        _mint(to, newItemId);
        _setTokenURI(newItemId, tokenURI_);
        return newItemId;
    }

    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }
}
