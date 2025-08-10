#!/bin/bash
set -e

echo "🚦 Starting CI/CD pipeline..."

bash scripts/deploy_contract.sh
bash scripts/build_macos.sh

echo "🎉 Pipeline complete — ERC-20 deployed & macOS app signed."
