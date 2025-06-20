async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("🔐 Deploying with:", deployer.address);
  const Token = await ethers.getContractFactory("FadakaToken");
  const token = await Token.deploy();
  await token.deployed();
  console.log("✅ Deployed FDAK at:", token.address);
}
main().catch(console.error);
