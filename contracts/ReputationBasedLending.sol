// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReputationBasedLending {
    struct Loan {
        uint256 amount;
        uint256 interestRate;
        uint256 duration;
        uint256 startTime;
        bool repaid;
    }

    mapping(address => uint256) public reputationScores;
    mapping(address => Loan) public loans;

    function requestLoan(uint256 amount, uint256 interestRate, uint256 duration) public {
        require(reputationScores[msg.sender] > 50, "Low reputation score");
        loans[msg.sender] = Loan(amount, interestRate, duration, block.timestamp, false);
    }

    function repayLoan() public payable {
        Loan storage loan = loans[msg.sender];
        require(!loan.repaid, "Loan already repaid");
        uint256 interest = (loan.amount * loan.interestRate * (block.timestamp - loan.startTime)) / (365 days * 100);
        uint256 totalRepayment = loan.amount + interest;
        require(msg.value >= totalRepayment, "Insufficient repayment amount");
        loan.repaid = true;
        reputationScores[msg.sender] += 10; // Increase reputation score
    }

    function getLoanDetails() public view returns (uint256, uint256, uint256, uint256, bool) {
        Loan memory loan = loans[msg.sender];
        return (loan.amount, loan.interestRate, loan.duration, loan.startTime, loan.repaid);
    }
}
