struct VaultAsset {
    string assetName;
    uint256 balance;
}

mapping(string => VaultAsset) public vaultHoldings;

function rebalanceAsset(string memory _asset, uint256 _amount) external onlyAI {
    vaultHoldings[_asset].balance += _amount;
}
