// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

interface IStones is IERC1155 {
  function mintStone(address to, uint256 id) external;

  function burnStone(address from, uint256 id) external;
}
