const { ethers } = require("hardhat");

async function main() {
  const proxyAddress = "YOUR_PROXY_ADDRESS_HERE";
  const fadaka = await ethers.getContractAt("FadakaTokenV2", proxyAddress);

  const MINTER_ROLE = await fadaka.MINTER_ROLE();
  const newMinter = "0xADDRESS_TO_GRANT_MINTER"; // Replace!

  const tx = await fadaka.grantRole(MINTER_ROLE, newMinter);
  await tx.wait();

  console.log(`✅ MINTER_ROLE granted to ${newMinter}`);
}

main().catch(console.error);
