// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlayerTransfer {
    struct Player {
        string name;
        address currentTeam;
        uint256 transferFee;
    }

    mapping(uint256 => Player) public players;
    uint256 public playerCount;

    function addPlayer(string memory name, address team, uint256 transferFee) public {
        playerCount++;
        players[playerCount] = Player(name, team, transferFee);
    }

    function transferPlayer(uint256 playerId, address newTeam) public payable {
        Player storage player = players[playerId];
        require(msg.value >= player.transferFee, "Insufficient transfer fee");
        player.currentTeam = newTeam;
    }

    function getPlayer(uint256 playerId) public view returns (string memory, address, uint256) {
        Player memory player = players[playerId];
        return (player.name, player.currentTeam, player.transferFee);
    }
}
