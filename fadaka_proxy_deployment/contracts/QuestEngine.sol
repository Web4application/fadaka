// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract QuestEngine is Initializable {
    mapping(address => string[]) public activeQuests;
    mapping(address => uint256) public reputationScore;

    address public Web4Agent;

    event QuestCompleted(address indexed player, string questName);

    modifier onlyAgent() {
        require(msg.sender == Web4Agent, "Unauthorized AI agent");
        _;
    }

    function initialize(address _agent) public initializer {
        Web4Agent = _agent;
    }

    function completeQuest(address player, string memory questName) public onlyAgent {
        activeQuests[player].push(questName);
        reputationScore[player] += 10;
        emit QuestCompleted(player, questName);
    }
}
