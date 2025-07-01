// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";

/// @title OpenERC1155Receiver
/// @notice Minimal, payable receiver that accepts all ERC‑1155 transfers.
contract OpenERC1155Receiver is ERC1155Receiver {
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) public pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) public pure override returns (bytes4) {
        return this.onERC1155BatchReceived.selector; // ✅ Fixed
    }

    fallback() external payable {}
    receive() external payable {}
}

