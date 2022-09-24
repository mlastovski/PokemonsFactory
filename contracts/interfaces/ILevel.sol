// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ILevel is IERC20 {
  function mintLevel(address to, uint256 amount) external;

  function burnLevel(address from, uint256 amount) external;
}
