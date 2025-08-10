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

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with", deployer.address);

  const Fadaka = await ethers.getContractFactory("FadakaToken");
  // Replace args: name, symbol, initialSupply (whole tokens)
  const token = await Fadaka.deploy("Fadaka Token", "FAD", 1000000);
  await token.deployed();

  console.log("Token deployed to:", token.address);
}
main().catch(e => { console.error(e); process.exit(1); });
