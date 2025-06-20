// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FadakaSubscription {
    struct Subscription {
        address subscriber;
        uint256 amount;
        uint256 startTime;
        uint256 duration;
    }

    mapping(address => Subscription) public subscriptions;

    function subscribe(uint256 amount, uint256 duration) public payable {
        require(msg.value == amount, "Incorrect payment amount");
        subscriptions[msg.sender] = Subscription(msg.sender, amount, block.timestamp, duration);
    }

    function checkSubscription(address subscriber) public view returns (bool) {
        Subscription memory subscription = subscriptions[subscriber];
        return block.timestamp < subscription.startTime + subscription.duration;
    }
}
