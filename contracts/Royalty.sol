// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoyaltyDistribution {
    struct Royalty {
        address artist;
        uint256 percentage;
    }

    mapping(uint256 => Royalty) public royalties;
    uint256 public royaltyCount;

    function addRoyalty(address artist, uint256 percentage) public {
        royaltyCount++;
        royalties[royaltyCount] = Royalty(artist, percentage);
    }

    function distributeRoyalties(uint256 amount) public payable {
        require(msg.value == amount, "Incorrect amount sent");
        for (uint256 i = 1; i <= royaltyCount; i++) {
            Royalty memory royalty = royalties[i];
            uint256 payment = (amount * royalty.percentage) / 100;
            payable(royalty.artist).transfer(payment);
        }
    }
}
