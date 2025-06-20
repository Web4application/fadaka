async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with account:", deployer.address);

  const FadakaToken = await ethers.getContractFactory("FadakaToken");
  const initialSupply = ethers.utils.parseUnits("1000000000", 18); // 1 billion tokens
  const fadakaToken = await FadakaToken.deploy(initialSupply);

  await fadakaToken.deployed();

  console.log("FadakaToken deployed to:", fadakaToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
