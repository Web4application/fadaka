// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sponsorship {
    struct Sponsor {
        address sponsorAddress;
        uint256 amount;
        string message;
    }

    mapping(uint256 => Sponsor) public sponsors;
    uint256 public sponsorCount;

    function addSponsor(string memory message) public payable {
        require(msg.value > 0, "Sponsorship amount must be greater than zero");
        sponsorCount++;
        sponsors[sponsorCount] = Sponsor(msg.sender, msg.value, message);
    }

    function getSponsor(uint256 sponsorId) public view returns (address, uint256, string memory) {
        Sponsor memory sponsor = sponsors[sponsorId];
        return (sponsor.sponsorAddress, sponsor.amount, sponsor.message);
    }
}
