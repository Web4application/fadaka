modifier onlyTrusted(address _addr) {
    require(reputationScore[_addr] > 70, "Low trust");
    _;
}

function moderateProposal(uint proposalId) public onlyAI {
    // logic to auto-flag based on metadata and player history
}
