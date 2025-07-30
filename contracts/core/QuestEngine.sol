mapping(address => string[]) public activeQuests;
event QuestCompleted(address indexed player, string questName);

function completeQuest(address _player, string memory _quest) public onlyAgent {
    activeQuests[_player].push(_quest);
    reputationScore[_player] += 10;
    emit QuestCompleted(_player, _quest);
}
