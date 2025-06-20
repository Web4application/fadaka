// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarbonCreditTrading {
    struct Credit {
        uint256 amount;
        address owner;
    }

    mapping(uint256 => Credit) public credits;
    uint256 public creditCount;

    function createCredit(uint256 amount) public {
        creditCount++;
        credits[creditCount] = Credit(amount, msg.sender);
    }

    function transferCredit(uint256 creditId, address newOwner) public {
        Credit storage credit = credits[creditId];
        require(msg.sender == credit.owner, "Only owner can transfer credit");
        credit.owner = newOwner;
    }

    function getCredit(uint256 creditId) public view returns (uint256, address) {
        Credit memory credit = credits[creditId];
        return (credit.amount, credit.owner);
    }
}
