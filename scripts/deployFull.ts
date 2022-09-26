import { ethers } from "hardhat";

async function main() {
  // Level.sol 
  const Level = await ethers.getContractFactory("Level");
  const level = await Level.deploy();
  await level.deployed();
  console.log("Level deployed to: ", level.address);

  // Stones.sol 
  const Stones = await ethers.getContractFactory("Stones");
  const stones = await Stones.deploy("ipfs://bafybeia7lxsg6ne457glpcilj24maq2lssgf4m5jaallqqqpzwl6kicpky/");
  await stones.deployed();
  console.log("Stones deployed to: ", stones.address);

  // Pokemons.sol 
  const Pokemons = await ethers.getContractFactory("Pokemons");
  const pokemons = await Pokemons.deploy("ipfs://bafybeigzd63bbd725waoem5uexjnxfoedjecf7q5b3qt3zwxm6zb4gl6a4/");
  await pokemons.deployed();
  console.log("Pokemons deployed to: ", pokemons.address);

  // PokemonsFactory.sol 
  const PokemonsFactory = await ethers.getContractFactory("PokemonsFactory");
  const pokemonsFactory = await PokemonsFactory.deploy(
    level.address,
    stones.address,
    pokemons.address,
    2004,
    "0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed"
  );
  await pokemonsFactory.deployed();
  console.log("PokemonsFactory deployed to: ", pokemonsFactory.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
