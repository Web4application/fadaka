#!/bin/bash
echo "🛠 Deploying FDAK + Router + Faucet via Hardhat..."

cd smart-contracts
npx hardhat run scripts/deploy.js --network localhost
