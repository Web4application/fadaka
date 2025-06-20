// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FadakaStaking {
    struct Stake {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Stake) public stakes;
    uint256 public rewardRate = 100; // Example reward rate

    function stakeTokens(uint256 amount) public {
        stakes[msg.sender] = Stake(amount, block.timestamp);
    }

    function calculateReward(address staker) public view returns (uint256) {
        Stake memory stake = stakes[staker];
        uint256 duration = block.timestamp - stake.timestamp;
        return (stake.amount * rewardRate * duration) / (365 days);
    }

    function withdrawReward() public {
        uint256 reward = calculateReward(msg.sender);
        // Transfer reward to staker
    }
}
