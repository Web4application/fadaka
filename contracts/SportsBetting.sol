// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SportsBetting {
    struct Bet {
        uint256 amount;
        uint256 odds;
        bool settled;
        bool won;
    }

    mapping(address => Bet) public bets;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function placeBet(uint256 odds) public payable {
        require(msg.value > 0, "Bet amount must be greater than zero");
        bets[msg.sender] = Bet(msg.value, odds, false, false);
    }

    function settleBet(address bettor, bool won) public {
        require(msg.sender == owner, "Only owner can settle bets");
        Bet storage bet = bets[bettor];
        require(!bet.settled, "Bet already settled");
        bet.settled = true;
        bet.won = won;
        if (won) {
            uint256 payout = bet.amount * bet.odds;
            payable(bettor).transfer(payout);
        }
    }

    function getBet(address bettor) public view returns (uint256, uint256, bool, bool) {
        Bet memory bet = bets[bettor];
        return (bet.amount, bet.odds, bet.settled, bet.won);
    }
}
