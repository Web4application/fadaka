mapping(address => uint256) public reputationScore;
mapping(address => bool) public verifiedSovereigns;

function verifySovereign(address _addr) external onlyModerator {
    verifiedSovereigns[_addr] = true;
    reputationScore[_addr] = 50; // starter trust
}
