import { ethers } from "hardhat";

async function main() {
  const Stones = await ethers.getContractFactory("Stones");
  const stones = await Stones.deploy("ipfs://bafybeia7lxsg6ne457glpcilj24maq2lssgf4m5jaallqqqpzwl6kicpky/");

  await stones.deployed();

  console.log("Stones deployed to: ", stones.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
