const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("OpenERC1155Receiver", function () {
  let receiver, erc1155, owner;

  beforeEach(async () => {
    [owner] = await ethers.getSigners();

    const Receiver = await ethers.getContractFactory("OpenERC1155Receiver");
    receiver = await Receiver.deploy();

    const ERC1155Mock = await ethers.getContractFactory("ERC1155Mock");
    erc1155 = await ERC1155Mock.deploy("https://uri.example/{id}.json");
    await erc1155.mint(owner.address, 1, 10, "0x");
    await erc1155.setApprovalForAll(receiver.address, true);
  });

  it("accepts single token transfer", async () => {
    await erc1155.safeTransferFrom(owner.address, receiver.address, 1, 1, "0x");
    expect(await erc1155.balanceOf(receiver.address, 1)).to.equal(1);
  });

  it("accepts batch token transfer", async () => {
    await erc1155.mint(owner.address, 2, 5, "0x");
    await erc1155.safeBatchTransferFrom(
      owner.address,
      receiver.address,
      [1, 2],
      [2, 5],
      "0x"
    );
    expect(await erc1155.balanceOf(receiver.address, 1)).to.equal(2);
    expect(await erc1155.balanceOf(receiver.address, 2)).to.equal(5);
  });
});
