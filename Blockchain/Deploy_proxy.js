const { ethers, upgrades } = require("hardhat");

async function main() {
  const FadakaToken = await ethers.getContractFactory("FadakaToken");
  const proxy = await upgrades.deployProxy(FadakaToken, [], {
    initializer: "initialize",
  });

  await proxy.deployed();
  console.log("✅ Proxy deployed to:", proxy.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
