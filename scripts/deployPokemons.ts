import { ethers } from "hardhat";

async function main() {
  const Pokemons = await ethers.getContractFactory("Pokemons");
  const pokemons = await Pokemons.deploy("ipfs://bafybeigzd63bbd725waoem5uexjnxfoedjecf7q5b3qt3zwxm6zb4gl6a4/");

  await pokemons.deployed();

  console.log("Pokemons deployed to: ", pokemons.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
