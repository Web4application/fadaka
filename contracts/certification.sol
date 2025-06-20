// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Certification {
    struct Certificate {
        uint256 id;
        address recipient;
        string courseName;
        uint256 issueDate;
    }

    mapping(uint256 => Certificate) public certificates;
    uint256 public certificateCount;

    function issueCertificate(address recipient, string memory courseName) public {
        certificateCount++;
        certificates[certificateCount] = Certificate(certificateCount, recipient, courseName, block.timestamp);
    }

    function getCertificate(uint256 certificateId) public view returns (address, string memory, uint256) {
        Certificate memory certificate = certificates[certificateId];
        return (certificate.recipient, certificate.courseName, certificate.issueDate);
    }
}
