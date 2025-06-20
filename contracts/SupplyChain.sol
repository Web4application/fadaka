// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    struct Product {
        uint256 id;
        string name;
        address owner;
        uint256 price;
        bool forSale;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    function addProduct(string memory name, uint256 price) public {
        productCount++;
        products[productCount] = Product(productCount, name, msg.sender, price, true);
    }

    function buyProduct(uint256 productId) public payable {
        Product storage product = products[productId];
        require(product.forSale, "Product not for sale");
        require(msg.value >= product.price, "Insufficient payment");
        product.owner = msg.sender;
        product.forSale = false;
        payable(product.owner).transfer(msg.value);
    }

    function getProduct(uint256 productId) public view returns (string memory, address, uint256, bool) {
        Product memory product = products[productId];
        return (product.name, product.owner, product.price, product.forSale);
    }
}
