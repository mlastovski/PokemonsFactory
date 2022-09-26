import { ethers } from "hardhat";

async function main() {
  const Level = await ethers.getContractFactory("Level");
  const level = await Level.deploy();

  await level.deployed();

  console.log("Level deployed to: ", level.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
