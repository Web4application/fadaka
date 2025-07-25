// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../contracts/FadakaToken.sol";

contract FadakaTokenTest is Test {
    FadakaToken token;

    function setUp() public {
        token = new FadakaToken();
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 * 10 ** token.decimals());
    }

    function testTransfer() public {
        address recipient = address(0xBEEF);
        token.transfer(recipient, 100 * 10 ** token.decimals());
        assertEq(token.balanceOf(recipient), 100 * 10 ** token.decimals());
    }
}
