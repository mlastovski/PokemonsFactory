import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract, ContractFactory, BigNumber } from "ethers";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import { parseEther } from "ethers/lib/utils";

// TODO: events coverage
describe("PokemonsFactory", function () {
  let Level: ContractFactory;
  let level: Contract;

  let Stones: ContractFactory;
  let stones: Contract;

  let Pokemons: ContractFactory;
  let pokemons: Contract;

  let PokemonsFactory: ContractFactory;
  let pokemonsFactory: Contract;

  let vrfCoordinatorV2Mock: ContractFactory;
  let hardhatVrfCoordinatorV2Mock: Contract;

  let owner: SignerWithAddress;
  let alice: SignerWithAddress;
  let bob: SignerWithAddress;

  before(async function () {
    [owner, alice, bob] = await ethers.getSigners();

    Level = await ethers.getContractFactory("Level");
    level = await Level.deploy();
    await level.deployed();

    Stones = await ethers.getContractFactory("Stones");
    stones = await Stones.deploy("ipfs://bafybeia7lxsg6ne457glpcilj24maq2lssgf4m5jaallqqqpzwl6kicpky/");
    await stones.deployed();

    Pokemons = await ethers.getContractFactory("Pokemons");
    pokemons = await Pokemons.deploy("ipfs://bafybeigzd63bbd725waoem5uexjnxfoedjecf7q5b3qt3zwxm6zb4gl6a4/");
    await pokemons.deployed();

    vrfCoordinatorV2Mock = await ethers.getContractFactory("VRFCoordinatorV2Mock");
    hardhatVrfCoordinatorV2Mock = await vrfCoordinatorV2Mock.deploy(0, 0);
    await hardhatVrfCoordinatorV2Mock.deployed();
    await hardhatVrfCoordinatorV2Mock.createSubscription();
    await hardhatVrfCoordinatorV2Mock.fundSubscription(1, parseEther("7"));

    PokemonsFactory = await ethers.getContractFactory("PokemonsFactory");
    pokemonsFactory = await PokemonsFactory.deploy(
      level.address, 
      stones.address, 
      pokemons.address,
      1,
      hardhatVrfCoordinatorV2Mock.address
    );
    await pokemonsFactory.deployed();

    await level.initialize(pokemonsFactory.address);
    await stones.initialize(pokemonsFactory.address);
    await pokemons.initialize(pokemonsFactory.address);
  });

  describe("getLevels", function () {
    it("Should get 100 levels", async function () {
      await pokemonsFactory.connect(alice).getLevels(100);

      expect(await level.balanceOf(alice.address))
        .to.equal(parseEther("100"));
    });

    it("Should fail get 0 levels (Insufficient amount)", async function () {
      await expect(pokemonsFactory.connect(alice).getLevels(0))
        .to.be.revertedWith("Insufficient amount");
    });
  });

  describe("getStone", function () {
    it("Should get a stone with id = 1", async function () {
      const id = 1;
      await pokemonsFactory.connect(alice).getStone(id);

      expect(await stones.balanceOf(alice.address, id))
        .to.equal(BigNumber.from("1"));
    });

    it("Should fail to get a stone with id = 5 (Wrong id)", async function () {
      const id = 5;

      await expect(pokemonsFactory.connect(alice).getStone(id))
        .to.be.revertedWith("Wrong id");
    });
  });

  describe("getRandomPokemon", function () {
    it("Should mint a random Pokemon to alice properly", async function () {
      const tx = await pokemonsFactory.connect(alice).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);

      for (let id = 1; id < 10; id++) {
        const balance = await pokemons.balanceOf(alice.address, id);
        console.log(balance);
      };
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);

      for (let id = 1; id < 10; id++) {
        const balance = await pokemons.balanceOf(bob.address, id);
        console.log(balance);
      };
    });
  });

  describe("evolvePokemon", function () {
    it("Should evolve from Pikachu to Raichu properly", async function () {
      
    });
  });
});
