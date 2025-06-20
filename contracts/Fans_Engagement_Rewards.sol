// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FanEngagement {
    struct Reward {
        address fan;
        uint256 points;
    }

    mapping(address => Reward) public rewards;

    function addPoints(address fan, uint256 points) public {
        rewards[fan].points += points;
    }

    function redeemPoints(address fan, uint256 points) public {
        require(rewards[fan].points >= points, "Insufficient points");
        rewards[fan].points -= points;
        // Implement reward redemption logic here
    }

    function getPoints(address fan) public view returns (uint256) {
        return rewards[fan].points;
    }
}
