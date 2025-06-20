// Solidity contract for cross-chain compatibility
pragma solidity ^0.8.0;

contract CrossChainBridge {
    event CrossChainTransfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address to, uint256 amount) public {
        // Logic for transferring assets across chains
        emit CrossChainTransfer(msg.sender, to, amount);
    }
}
