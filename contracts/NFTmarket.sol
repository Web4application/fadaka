// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract FadakaMarketplace {
    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
    }

    mapping(uint256 => Listing) public listings;

    function listNFT(uint256 tokenId, uint256 price, address nftContract) public {
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        listings[tokenId] = Listing(tokenId, msg.sender, price);
    }

    function buyNFT(uint256 tokenId, address nftContract) public payable {
        Listing memory listing = listings[tokenId];
        require(msg.value >= listing.price, "Insufficient payment");
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        payable(listing.seller).transfer(msg.value);
        delete listings[tokenId];
    }
}
