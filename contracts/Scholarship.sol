// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScholarshipFund {
    struct Scholarship {
        address recipient;
        uint256 amount;
        bool claimed;
    }

    mapping(uint256 => Scholarship) public scholarships;
    uint256 public scholarshipCount;

    function createScholarship(address recipient, uint256 amount) public {
        scholarshipCount++;
        scholarships[scholarshipCount] = Scholarship(recipient, amount, false);
    }

    function claimScholarship(uint256 scholarshipId) public {
        Scholarship storage scholarship = scholarships[scholarshipId];
        require(msg.sender == scholarship.recipient, "Only recipient can claim scholarship");
        require(!scholarship.claimed, "Scholarship already claimed");
        scholarship.claimed = true;
        payable(scholarship.recipient).transfer(scholarship.amount);
    }

    function getScholarship(uint256 scholarshipId) public view returns (address, uint256, bool) {
        Scholarship memory scholarship = scholarships[scholarshipId];
        return (scholarship.recipient, scholarship.amount, scholarship.claimed);
    }
}
