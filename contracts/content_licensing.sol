// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContentLicensing {
    struct License {
        address licensee;
        uint256 contentId;
        uint256 expiration;
    }

    mapping(uint256 => License) public licenses;
    uint256 public licenseCount;

    function createLicense(address licensee, uint256 contentId, uint256 duration) public {
        licenseCount++;
        licenses[licenseCount] = License(licensee, contentId, block.timestamp + duration);
    }

    function checkLicense(uint256 licenseId) public view returns (bool) {
        License memory license = licenses[licenseId];
        return block.timestamp < license.expiration;
    }

    function getLicense(uint256 licenseId) public view returns (address, uint256, uint256) {
        License memory license = licenses[licenseId];
        return (license.licensee, license.contentId, license.expiration);
    }
}
