const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("🛠 Deploying FadakaTokenV2 with deployer:", deployer.address);

  const FadakaTokenV2 = await ethers.getContractFactory("FadakaTokenV2");

  const proxy = await upgrades.deployProxy(FadakaTokenV2, [], {
    initializer: "initialize",
    kind: "transparent",
  });

  console.log("✅ Proxy deployed at:", await proxy.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
