// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../contracts/FadakaToken.sol";

contract DeployFadakaToken is Script {
    function run() external {
        vm.startBroadcast();
        new FadakaToken();
        vm.stopBroadcast();
    }
}
