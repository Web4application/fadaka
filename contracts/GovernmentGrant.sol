// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GovernmentGrant {
    struct Grant {
        address recipient;
        uint256 amount;
        bool claimed;
    }

    mapping(uint256 => Grant) public grants;
    uint256 public grantCount;

    function createGrant(address recipient, uint256 amount) public {
        grantCount++;
        grants[grantCount] = Grant(recipient, amount, false);
    }

    function claimGrant(uint256 grantId) public {
        Grant storage grant = grants[grantId];
        require(msg.sender == grant.recipient, "Only recipient can claim grant");
        require(!grant.claimed, "Grant already claimed");
        grant.claimed = true;
        payable(grant.recipient).transfer(grant.amount);
    }

    function getGrant(uint256 grantId) public view returns (address, uint256, bool) {
        Grant memory grant = grants[grantId];
        return (grant.recipient, grant.amount, grant.claimed);
    }
}
