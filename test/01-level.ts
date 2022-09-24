import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract, ContractFactory } from "ethers";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import { parseEther } from "ethers/lib/utils";

// TODO: events coverage
describe("Level", function () {
  let Level: ContractFactory;
  let level: Contract;

  let owner: SignerWithAddress;
  let alice: SignerWithAddress;
  let bob: SignerWithAddress;

  before(async function () {
    [owner, alice, bob] = await ethers.getSigners();

    Level = await ethers.getContractFactory("Level");
    level = await Level.deploy(parseEther("0.0001"));

    await level.deployed();
  });

  describe("getPrice", function () {
    it("Should check if currentPrice = 0.0001 ETH", async function () {
      expect(await level.getPrice())
        .to.equal(parseEther("0.0001"));
    })
  });

  describe("buy", function () {
    it("Should fail to buy Level tokens (LVL: Insufficient ETH amount)", async function () {
      const amount = parseEther("0");

      await expect(level.connect(alice).buy({value: amount}))
        .to.be.revertedWith("LVL: Insufficient ETH amount");
    });

    it("Should buy 100 Level tokens", async function () {
      const amount = parseEther("0.01");
      await level.connect(alice).buy({value: amount});

      expect(await level.balanceOf(alice.address))
        .to.equal(parseEther("100"));
    });
  });

  describe("updatePrice", function () {
    it("Should update price properly", async function () {
      await level.connect(owner).updatePrice(parseEther("0.01"));

      expect(await level.getPrice())
        .to.equal(parseEther("0.01"));
    });
  });

  // TODO: complete balance check
  describe("withdraw", function () {
    it("Should withdraw ETH properly", async function () {
      await level.connect(owner).withdraw();

      expect(await ethers.provider.getBalance(level.address))
        .to.equal(parseEther("0"));
    });
  });
});