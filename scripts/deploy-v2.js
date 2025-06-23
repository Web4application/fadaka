const { ethers, upgrades } = require("hardhat");

async function main() {
    const FadakaToken = await ethers.getContractFactory("FadakaTokenUpgradeable");
    const fadaka = await upgrades.deployProxy(FadakaToken, [], { initializer: "initialize" });
    await fadaka.waitForDeployment();
    console.log("FadakaToken deployed to:", await fadaka.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
