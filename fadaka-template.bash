#!/usr/bin/env bash
set -e
# 1. Clone into new folder
mkdir fadaka-blockchain && cd fadaka-blockchain

# 2. Create project structure
cat > .nvmrc << 'EOF'
18
EOF

cat > package.json << 'EOF'
{ /* use package.json content generated earlier */ }
EOF

cat > hardhat.config.js << 'EOF'
/* use hardhat.config.js content generated above */
EOF

cat > .solhint.json << 'EOF'
{ /* solhint config content */ }
EOF

cat > .eslintrc.json << 'EOF'
{ /* eslint config content */ }
EOF

cat > .prettierrc << 'EOF'
{ /* prettier config content */ }
EOF

mkdir -p contracts scripts test .github/workflows

cat > contracts/FadakaToken.sol << 'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FadakaToken {
    string public name = "Fadaka";
    string public symbol = "FDK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
    }
}
EOF

cat > scripts/deploy.js << 'EOF'
async function main() {
    const [deployer] = await ethers.getSigners();
    const Fadaka = await ethers.getContractFactory("FadakaToken");
    const token = await Fadaka.deploy(ethers.utils.parseUnits("1000000", 18));
    console.log("Deployed to:", token.address);
}

main().catch(console.error);
EOF

cat > test/FadakaToken.test.js << 'EOF'
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("FadakaToken", function () {
  it("Should deploy with initial supply", async function () {
    const [owner] = await ethers.getSigners();
    const Fadaka = await ethers.getContractFactory("FadakaToken");
    const token = await Fadaka.deploy(ethers.utils.parseUnits("5000", 18));
    expect(await token.totalSupply()).to.equal(ethers.utils.parseUnits("5000", 18));
  });
});
EOF

# Add GitHub Actions files from earlier in .github/workflows/
# (You'd echo those here as well similarly, or copy them)

# 3. Git initialize
git init
git add .
git commit -m "Initial Fadaka Blockchain starter"

# 4. Create GitHub repo and push
read -p "Enter new GitHub repo name (e.g. yourorg/fadaka-blockchain): " REPO
gh repo create "$REPO" --public --source=. --remote=origin --push

echo "🎉 Boilerplate pushed to https://github.com/$REPO"
