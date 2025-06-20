// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    struct Campaign {
        address payable creator;
        uint256 goal;
        uint256 pledged;
        uint256 deadline;
        bool claimed;
    }

    mapping(uint256 => Campaign) public campaigns;
    uint256 public campaignCount;

    function createCampaign(uint256 goal, uint256 duration) public {
        campaignCount++;
        campaigns[campaignCount] = Campaign(payable(msg.sender), goal, 0, block.timestamp + duration, false);
    }

    function pledge(uint256 campaignId) public payable {
        Campaign storage campaign = campaigns[campaignId];
        require(block.timestamp < campaign.deadline, "Campaign ended");
        campaign.pledged += msg.value;
    }

    function claimFunds(uint256 campaignId) public {
        Campaign storage campaign = campaigns[campaignId];
        require(msg.sender == campaign.creator, "Only creator can claim funds");
        require(block.timestamp >= campaign.deadline, "Campaign not ended");
        require(campaign.pledged >= campaign.goal, "Goal not reached");
        require(!campaign.claimed, "Funds already claimed");
        campaign.claimed = true;
        campaign.creator.transfer(campaign.pledged);
    }

    function getCampaign(uint256 campaignId) public view returns (address, uint256, uint256, uint256, bool) {
        Campaign memory campaign = campaigns[campaignId];
        return (campaign.creator, campaign.goal, campaign.pledged, campaign.deadline, campaign.claimed);
    }
}
