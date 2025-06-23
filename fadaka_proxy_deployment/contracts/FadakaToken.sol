// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract FadakaToken is Initializable, ERC20Upgradeable {
    function initialize() public initializer {
        __ERC20_init("FadakaToken", "FDAK");
        _mint(msg.sender, 1_000_000_000 * 10 ** decimals());
    }
}
