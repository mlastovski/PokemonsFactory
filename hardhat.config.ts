import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";
import "hardhat-contract-sizer";
import "hardhat-docgen";
import "@primitivefi/hardhat-dodoc";

dotenv.config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.11",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },

  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },

  networks: {
    rinkeby: {
      url: process.env.ALCHEMY_URL || "",
      accounts:
        process.env.MNEMONIC !== undefined ? [process.env.MNEMONIC] : [],
    },

    hardhat: {
      forking: {
        url: process.env.ALCHEMY_MUMBAI as string,
        enabled: true,
      }
    },

    matic: {
      url: process.env.ALCHEMY_MUMBAI || "",
      accounts:
        process.env.MNEMONIC !== undefined ? [process.env.MNEMONIC] : [],
    },

    bsc: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      gasPrice: 20000000000,
      accounts:
        process.env.MNEMONIC !== undefined ? [process.env.MNEMONIC] : [],
    }
  },

  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },

  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY,
  },

  docgen: {
    path: './docs',
    clear: true,
    runOnCompile: false,
  },
  
  dodoc: {
    runOnCompile: true,
    debugMode: true,
    exclude: [
      "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol",
      "node_modules/@openzeppelin/contracts/access/AccessControl.sol",
      "node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol",
      "node_modules/@openzeppelin/contracts/utils/Strings.sol",
      "node_modules/@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol",
      "node_modules/@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol",
    ]
  }
};

export default config;
