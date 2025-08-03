// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTokenV2 {
    string public name = "FadakaTokenV2";

    function greet() public pure returns (string memory) {
        return "Hello from V2";
    }
}