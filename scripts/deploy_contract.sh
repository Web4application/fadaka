#!/bin/bash
set -e

echo "🚀 Deploying ERC-20 contract to testnet..."
cd "$(dirname "$0")/../fadaka-blockchain"

# Example using Hardhat (adapt to your stack)
npx hardhat run scripts/deploy.js --network sepolia

echo "✅ ERC-20 contract deployed."
