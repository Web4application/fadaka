const hre = require("hardhat");

async function main() {
  const address = process.argv[2];
  const constructorArgs = process.argv.slice(3);

  if (!address) throw new Error("No address provided");

  await hre.run("verify:verify", {
    address,
    constructorArguments: constructorArgs
  });
}

main().catch(console.error);
