async function main() {
    const [deployer] = await ethers.getSigners();
    const contractAddress = "YOUR_DEPLOYED_CONTRACT_ADDRESS";

    const FadakaToken = await ethers.getContractFactory("FadakaToken");
    const fadakaToken = FadakaToken.attach(contractAddress);

    // Checking the total supply
    const totalSupply = await fadakaToken.totalSupply();
    console.log("Total supply:", ethers.utils.formatUnits(totalSupply, 18));

    // Sending tokens
    const recipient = "RECIPIENT_WALLET_ADDRESS";
    const amount = ethers.utils.parseUnits("100", 18);
    const transferTx = await fadakaToken.transfer(recipient, amount);
    await transferTx.wait();

    console.log("Transferred 100 FadakaTokens to:", recipient);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
