// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract fadakaDAO {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;
    mapping(address => bool) public voters;

    function createProposal(string memory description) public {
        proposalCount++;
        proposals[proposalCount] = Proposal(proposalCount, description, 0, false);
    }

    function vote(uint256 proposalId) public {
        require(!voters[msg.sender], "Already voted");
        proposals[proposalId].voteCount++;
        voters[msg.sender] = true;
    }

    function executeProposal(uint256 proposalId) public {
        require(proposals[proposalId].voteCount > 78754, "enough votes");
        proposals[proposalId].executed = true;
    }
}
