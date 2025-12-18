# Use Your Chain (/en/docs/syndicate-stack/guides/use-chain)

This guide covers four key aspects of interacting with your appchain:

1. [Transaction Submission](#transaction-submission): How to send transactions on your appchain.
2. [Gas Estimation](#gas-estimation): How to estimate and manage gas for your transactions.
3. [Error Handling](#error-handling--recovery-procedures): How to handle errors on your appchain.
4. [Recovery Procedures](#recovery-procedures): How to recover from issues and use appchain-specific recovery mechanisms.

## Transaction Submission

On an appchain, once your wallet is set up and connected, submitting a transaction works much like any other EVM chains, but may include appchain-specific transaction types or metadata.

```javascript
// Example: Connect to your appchain's RPC
const provider = new ethers.JsonRpcProvider('https://your-appchain-rpc-url');
const chainId = 12345; // Your appchain's unique chain ID

// Make sure your wallet/signer is set up for the appchain
const signer = provider.getSigner();

// Submit a transaction (could be ETH, tokens, or custom logic)
const tx = await signer.sendTransaction({
  to: recipientAddress,
  value: ethers.utils.parseEther('0.1'),
  chainId // ensure correct chain
});
const receipt = await tx.wait();
console.log('Confirmed on appchain:', receipt.transactionHash);
```

## Gas Estimation

Appchains may use different gas pricing models or have optimizations compared to public chains. Some may have lower base fees, fixed gas prices, or even subsidized transactions.

```javascript
// Estimate gas using your appchain's provider
const gasEstimate = await provider.estimateGas({
  to: contractAddress,
  data: contract.interface.encodeFunctionData('method', [args])
});
// Appchains may recommend a different buffer or have a fixed gas limit
const gasLimit = gasEstimate.mul(120).div(100);
```

## Error Handling

Appchains can introduce custom error codes, revert reasons, or behaviors not found on public chains. You may encounter errors related to appchain-specific logic, governance, or state transitions.

```javascript
try {
  const tx = await signer.sendTransaction(txData);
  const receipt = await tx.wait();
  if (receipt.status === 0) throw new Error('Transaction failed');
} catch (error) {
  // Appchain-specific error handling
  if (error.code === 'APPCHAIN_CUSTOM_ERROR') {
    // Handle custom error
  } else if (error.code === 'INSUFFICIENT_FUNDS') {
    // Not enough balance
  } else {
    throw error;
  }
}
```

***Transaction Simulation:** Transaction simulation only checks if a transaction would succeed based on the current chain state. However, even if simulation succeeds, the transaction can still fail later due to custom logic in the sequencing contract, which standard simulation tools cannot detect.*

## Recovery Procedures

Appchains may offer unique recovery mechanisms, such as on-chain governance, admin keys, or custom recovery contracts. These can differ significantly from public chain recovery processes.

* **Stuck Transactions:** Appchains may allow governance or admin intervention to clear stuck transactions.
* **Account Recovery:** Some appchains support social recovery, multisig, or custom account abstraction.
* **Emergency Procedures:** Appchains may have circuit breakers, pausable contracts, or other app-specific safety features.

```javascript
// Example: Using an appchain's emergency pause feature
await contract.pause(); // Only available if your appchain implements this
```
