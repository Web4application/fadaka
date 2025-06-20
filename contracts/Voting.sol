// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CreativeCrowdfunding {
    struct Project {
        address payable creator;
        uint256 goal;
        uint256 pledged;
        uint256 deadline;
        bool funded;
    }

    mapping(uint256 => Project) public projects;
    uint256 public projectCount;

    function createProject(uint256 goal, uint256 duration) public {
        projectCount++;
        projects[projectCount] = Project(payable(msg.sender), goal, 0, block.timestamp + duration, false);
    }

    function pledge(uint256 projectId) public payable {
        Project storage project = projects[projectId];
        require(block.timestamp < project.deadline, "Project funding period ended");
        project.pledged += msg.value;
    }

    function claimFunds(uint256 projectId) public {
        Project storage project = projects[projectId];
        require(msg.sender == project.creator, "Only creator can claim funds");
        require(block.timestamp >= project.deadline, "Project funding period not ended");
        require(project.pledged >= project.goal, "Funding goal not reached");
        require(!project.funded, "Funds already claimed");
        project.funded = true;
        project.creator.transfer(project.pledged);
    }

    function getProject(uint256 projectId) public view returns (address, uint256, uint256, uint256, bool) {
        Project memory project = projects[projectId];
        return (project.creator, project.goal, project.pledged, project.deadline, project.funded);
    }
}
