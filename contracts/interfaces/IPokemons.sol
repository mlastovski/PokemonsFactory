// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

interface IPokemons is IERC1155 {
  function mintPokemon(address to, uint256 id) external;

  function burnPokemon(address from, uint256 id) external;

  function getEvolution(uint256 pokemonId, uint256 assetId) external view returns (uint256, uint256);
}
