import { ethers } from "hardhat";
import { parseEther } from "ethers/lib/utils";

async function main() {
  const Level = await ethers.getContractFactory("Level");
  const level = await Level.deploy(parseEther("0.0001"));

  await level.deployed();

  console.log("Level deployed to: ", level.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
