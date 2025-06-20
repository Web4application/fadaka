// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loan {
    struct LoanDetails {
        uint256 amount;
        uint256 interestRate;
        uint256 duration;
        uint256 startTime;
        bool repaid;
    }

    mapping(address => LoanDetails) public loans;

    function requestLoan(uint256 amount, uint256 interestRate, uint256 duration) public {
        require(loans[msg.sender].amount == 0, "Existing loan must be repaid first");
        loans[msg.sender] = LoanDetails(amount, interestRate, duration, block.timestamp, false);
    }

    function repayLoan() public payable {
        LoanDetails storage loan = loans[msg.sender];
        require(!loan.repaid, "Loan already repaid");
        uint256 interest = (loan.amount * loan.interestRate * (block.timestamp - loan.startTime)) / (365 days * 100);
        uint256 totalRepayment = loan.amount + interest;
        require(msg.value >= totalRepayment, "Insufficient repayment amount");
        loan.repaid = true;
        payable(address(this)).transfer(totalRepayment);
    }

    function getLoanDetails() public view returns (uint256, uint256, uint256, uint256, bool) {
        LoanDetails memory loan = loans[msg.sender];
        return (loan.amount, loan.interestRate, loan.duration, loan.startTime, loan.repaid);
    }
}
