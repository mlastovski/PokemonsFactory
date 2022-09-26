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
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });
  });

  describe("modifyEvolution", function () {
    it("Should fail to modify an evolution (Pokemons: wrong input data)", async function () {
      await expect(pokemons.modifyEvolution(10, 10, 5, 0))
        .to.be.revertedWith("Pokemons: wrong input data");
    });
  });

  describe("uri", function () {
    it("Should return correct NFT metadata", async function () {
      const pikachuUri = "ipfs://bafybeigzd63bbd725waoem5uexjnxfoedjecf7q5b3qt3zwxm6zb4gl6a4/1.json";
      const thunderUri = "ipfs://bafybeia7lxsg6ne457glpcilj24maq2lssgf4m5jaallqqqpzwl6kicpky/1.json";

      expect(await pokemons.uri(1)).to.equal(pikachuUri);
      expect(await stones.uri(1)).to.equal(thunderUri);
    });
  });

  describe("supportsInterface", function () {
    it("Should return a bool indicating whether the interface is supported", async function () {
      expect(await stones.supportsInterface("0x70a08231"))
        .to.be.a('boolean');
      expect(await pokemons.supportsInterface("0x70a08231"))
        .to.be.a('boolean');
    });
  });

  describe("evolvePokemon", function () {
    it("Should fail to evolve from Pikachu to Raichu (ERC20: burn amount exceeds balance)", async function () {
      await expect(pokemonsFactory.connect(bob).evolvePokemon(1, 0))
        .to.be.revertedWith("ERC20: burn amount exceeds balance");
    });

    it("Should fail to evolve from Pikachu to Raichu (Pokemons: no available evolutions)", async function () {
      await expect(pokemonsFactory.connect(bob).evolvePokemon(10, 0))
        .to.be.revertedWith("Pokemons: no available evolutions");
    });

    it("Should fail to evolve from Pikachu to Raichu (Pokemons: no available evolutions)", async function () {
      await expect(pokemonsFactory.connect(bob).evolvePokemon(9, 0))
        .to.be.revertedWith("Pokemons: no available evolutions");
    });

    it("Should evolve from Pikachu to Raichu properly", async function () {
      await pokemonsFactory.connect(bob).getLevels(1000);
      await pokemonsFactory.connect(bob).evolvePokemon(1, 0);

      const balanceOfPikachu = await pokemons.balanceOf(bob.address, 1);
      const balanceOfRaichu = await pokemons.balanceOf(bob.address, 2);

      expect(balanceOfPikachu).to.equal(BigNumber.from("0"));
      expect(balanceOfRaichu).to.equal(BigNumber.from("1"));
    });

    it("Should evolve from Raichu to Ninetales properly", async function () {
      await pokemonsFactory.connect(bob).evolvePokemon(2, 0);

      const balanceOfRaichu = await pokemons.balanceOf(bob.address, 2);
      const balanceOfNinetales = await pokemons.balanceOf(bob.address, 3);

      expect(balanceOfRaichu).to.equal(BigNumber.from("0"));
      expect(balanceOfNinetales).to.equal(BigNumber.from("1"));
    });

    it("Should fail evolve from Ninetales to Staryu using ICE stone (ERC1155: burn amount exceeds balance)", async function () {
      await expect(pokemonsFactory.connect(bob).evolvePokemon(3, 2))
        .to.be.revertedWith("ERC1155: burn amount exceeds balance");
    });

    it("Should evolve from Ninetales to Staryu using ICE stone properly", async function () {
      await pokemonsFactory.connect(bob).getStone(1);
      await pokemonsFactory.connect(bob).getStone(2);
      await pokemonsFactory.connect(bob).getStone(3);
      await pokemonsFactory.connect(bob).getStone(4);

      await pokemonsFactory.connect(bob).evolvePokemon(3, 2);

      const balanceOfNinetales = await pokemons.balanceOf(bob.address, 3);
      const balanceOfStaryu = await pokemons.balanceOf(bob.address, 9);

      expect(balanceOfNinetales).to.equal(BigNumber.from("0"));
      expect(balanceOfStaryu).to.equal(BigNumber.from("1"));
    });

    it("Should evolve from Staryu to Starmie using FIRE stone properly", async function () {
      await pokemonsFactory.connect(bob).evolvePokemon(9, 4);

      const balanceOfStaryu = await pokemons.balanceOf(bob.address, 9);
      const balanceOfStarmie = await pokemons.balanceOf(bob.address, 8);

      expect(balanceOfStaryu).to.equal(BigNumber.from("0"));
      expect(balanceOfStarmie).to.equal(BigNumber.from("1"));
    });
  });

  describe("Minting random pokemons until bob gets a Vulpix", function () {
    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });

    it("Should mint a random Pokemon to bob properly", async function () {
      const tx = await pokemonsFactory.connect(bob).getRandomPokemon();
      const { events } = await tx.wait();
      const [requestId] = events.filter((x: { event: string; }) => x.event === "RequestedRandomness")[0].args;

      await hardhatVrfCoordinatorV2Mock.fulfillRandomWords(requestId, pokemonsFactory.address);
    });
  });

  describe("evolvePokemon", function () {
    it("Should evolve from Vulpix to Bellossom using THUNDER properly", async function () {
      await pokemonsFactory.connect(bob).evolvePokemon(4, 1);

      const balanceOfVulpix = await pokemons.balanceOf(bob.address, 4);
      const balanceOfBellossom = await pokemons.balanceOf(bob.address, 5);

      expect(balanceOfVulpix).to.equal(BigNumber.from("0"));
      expect(balanceOfBellossom).to.equal(BigNumber.from("3"));
    });

    it("Should evolve from Bellossom to Gloom properly", async function () {
      await pokemonsFactory.connect(bob).evolvePokemon(5, 0);

      const balanceOfBellossom = await pokemons.balanceOf(bob.address, 5);
      const balanceOfGloom = await pokemons.balanceOf(bob.address, 6);

      expect(balanceOfBellossom).to.equal(BigNumber.from("2"));
      expect(balanceOfGloom).to.equal(BigNumber.from("1"));
    });

    it("Should evolve from Gloom to Vileplume using MOON properly", async function () {
      await pokemonsFactory.connect(bob).evolvePokemon(6, 3);

      const balanceOfGloom = await pokemons.balanceOf(bob.address, 6);
      const balanceOfVileplume = await pokemons.balanceOf(bob.address, 7);

      expect(balanceOfGloom).to.equal(BigNumber.from("0"));
      expect(balanceOfVileplume).to.equal(BigNumber.from("3"));
    });

    it("Should evolve from Gloom to Starmie using FIRE properly", async function () {
      await pokemonsFactory.connect(alice).getStone(4);
      await pokemonsFactory.connect(alice).evolvePokemon(6, 4);

      const balanceOfGloom = await pokemons.balanceOf(alice.address, 6);
      const balanceOfStarmie = await pokemons.balanceOf(alice.address, 8);

      expect(balanceOfGloom).to.equal(BigNumber.from("0"));
      expect(balanceOfStarmie).to.equal(BigNumber.from("1"));
    });
  });
});
