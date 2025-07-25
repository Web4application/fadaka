// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FadakaToken is ERC20 {
    constructor() ERC20("Fadaka Token", "FDAK") {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}
