const { ethers, upgrades } = require("hardhat");

async function main() {
  const proxyAddress = "YOUR_PROXY_ADDRESS"; // Replace with the deployed proxy address
  const FadakaTokenV2 = await ethers.getContractFactory("FadakaTokenV2");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, FadakaTokenV2);
  console.log("✅ Upgrade complete. New implementation at:", await upgraded.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
