// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RealEstate {
    struct Property {
        uint256 id;
        string location;
        address owner;
        uint256 price;
        bool forSale;
    }

    mapping(uint256 => Property) public properties;
    uint256 public propertyCount;

    function addProperty(string memory location, uint256 price) public {
        propertyCount++;
        properties[propertyCount] = Property(propertyCount, location, msg.sender, price, true);
    }

    function buyProperty(uint256 propertyId) public payable {
        Property storage property = properties[propertyId];
        require(property.forSale, "Property not for sale");
        require(msg.value >= property.price, "Insufficient payment");
        property.owner = msg.sender;
        property.forSale = false;
        payable(property.owner).transfer(msg.value);
    }

    function getProperty(uint256 propertyId) public view returns (string memory, address, uint256, bool) {
        Property memory property = properties[propertyId];
        return (property.location, property.owner, property.price, property.forSale);
    }
}
