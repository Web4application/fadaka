async function main() {
  const Receiver = await ethers.getContractFactory("OpenERC1155Receiver");
  const receiver = await Receiver.deploy();
  await receiver.deployed();
  console.log("✅ OpenERC1155Receiver deployed at:", receiver.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
