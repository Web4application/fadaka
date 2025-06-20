pragma solidity ^0.8.0;

contract Governance {
    mapping(address => uint256) public votes;
    address[] public candidates;

    function vote(address candidate) public {
        votes[candidate] += 1;
    }

    function getVotes(address candidate) public view returns (uint256) {
        return votes[candidate];
    }
}
