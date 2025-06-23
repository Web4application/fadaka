const fs = require("fs");
const path = require("path");

async function main() {
  const contractsDir = path.join(__dirname, "../contracts");
  const files = fs.readdirSync(contractsDir).filter(file => file.endsWith(".sol"));

  for (const file of files) {
    const contractName = file.replace(".sol", "");
    const ContractFactory = await ethers.getContractFactory(contractName);
    const contract = await ContractFactory.deploy();
    await contract.deployed();

    console.log(`${contractName} deployed at: ${contract.address}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
