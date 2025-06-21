# ERC-1155 Receiver Smart Contract Analysis

## Function: onERC1155Received(address,address,uint256,uint256,bytes)

### Parameters
- **operator**: 0x9Bf1810999CF0b79BeEC235308f272567064f966
- **from**: 0x9Bf1810999CF0b79BeEC235308f272567064f966
- **id**: 308
- **value**: 1
- **data**: 0x

### Purpose
Triggered automatically when ERC-1155 tokens are transferred to this contract.

### Contract Bytecode Analysis
This contract is a minimal ERC-1155 receiver that only implements `onERC1155Received`.

It returns the required function selector `0xf23a6e61` and reverts any unrecognized function calls by default unless modified.

### Solidity Source Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract OpenERC1155Receiver is IERC1155Receiver, ERC165 {
    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return interfaceId == type(IERC1155Receiver).interfaceId
            || super.supportsInterface(interfaceId);
    }

    fallback() external payable {}
    receive() external payable {}
}
