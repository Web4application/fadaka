// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EducationGrant {
    struct Grant {
        address recipient;
        uint256 amount;
        uint256 duration;
        uint256 startTime;
        bool claimed;
    }

    mapping(uint256 => Grant) public grants;
    uint256 public grantCount;

    function createGrant(address recipient, uint256 amount, uint256 duration) public {
        grantCount++;
        grants[grantCount] = Grant(recipient, amount, duration, block.timestamp, false);
    }

    function claimGrant(uint256 grantId) public {
        Grant storage grant = grants[grantId];
        require(msg.sender == grant.recipient, "Only recipient can claim grant");
        require(!grant.claimed, "Grant already claimed");
        require(block.timestamp >= grant.startTime + grant.duration, "Grant duration not met");
        grant.claimed = true;
        payable(grant.recipient).transfer(grant.amount);
    }

    function getGrant(uint256 grantId) public view returns (address, uint256, uint256, uint256, bool) {
        Grant memory grant = grants[grantId];
        return (grant.recipient, grant.amount, grant.duration, grant.startTime, grant.claimed);
    }
}
