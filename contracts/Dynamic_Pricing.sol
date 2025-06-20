// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicPricing {
    uint256 public basePrice;
    uint256 public supply;
    uint256 public demand;

    constructor(uint256 _basePrice) {
        basePrice = _basePrice;
        supply = 100; // Initial supply
        demand = 100; // Initial demand
    }

    function updateSupply(uint256 _supply) public {
        supply = _supply;
    }

    function updateDemand(uint256 _demand) public {
        demand = _demand;
    }

    function getPrice() public view returns (uint256) {
        return basePrice * demand / supply;
    }
}
