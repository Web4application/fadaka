// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StateFunds {
    struct Fund {
        address recipient;
        uint256 amount;
        bool allocated;
    }

    mapping(uint256 => Fund) public funds;
    uint256 public fundCount;

    function allocateFunds(address recipient, uint256 amount) public {
        fundCount++;
        funds[fundCount] = Fund(recipient, amount, false);
    }

    function claimFunds(uint256 fundId) public {
        Fund storage fund = funds[fundId];
        require(msg.sender == fund.recipient, "Only recipient can claim funds");
        require(!fund.allocated, "Funds already allocated");
        fund.allocated = true;
        payable(fund.recipient).transfer(fund.amount);
    }

    function getFund(uint256 fundId) public view returns (address, uint256, bool) {
        Fund memory fund = funds[fundId];
        return (fund.recipient, fund.amount, fund.allocated);
    }
}
