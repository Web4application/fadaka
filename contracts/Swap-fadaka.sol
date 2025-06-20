// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FadakaSwap {
    IERC20 public fadakaToken;
    IERC20 public otherToken;
    address public owner;

    // Swap rate example: how many otherTokens for 1 FadakaCoin
    uint256 public rate = 100;

    constructor(address _fadakaToken, address _otherToken) {
        fadakaToken = IERC20(_fadakaToken);
        otherToken = IERC20(_otherToken);
        owner = msg.sender;
    }

    // Owner can update swap rate
    function setRate(uint256 newRate) external {
        require(msg.sender == owner, "Only owner");
        rate = newRate;
    }

    // Swap FadakaCoin for otherToken
    function swap(uint256 fadakaAmount) external {
        require(fadakaAmount > 0, "Amount must be > 0");

        // Calculate amount of otherToken to send
        uint256 otherAmount = fadakaAmount * rate;

        // Transfer FadakaCoin from sender to this contract
        require(
            fadakaToken.transferFrom(msg.sender, address(this), fadakaAmount),
            "Fadaka transfer failed"
        );

        // Check contract balance of otherToken
        require(
            otherToken.balanceOf(address(this)) >= otherAmount,
            "Insufficient otherToken liquidity"
        );

        // Send otherToken to sender
        require(
            otherToken.transfer(msg.sender, otherAmount),
            "Other token transfer failed"
        );
    }
}
