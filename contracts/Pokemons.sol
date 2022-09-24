//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Pokemons is ERC1155, AccessControl {
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    string public ipfsLocation;

    string public name = "Pokemons";

    string public symbol = "PKMNS";

    uint256 public constant PIKACHU = 1;

    uint256 public constant RAICHU = 2;

    uint256 public constant NINETALES = 3;

    uint256 public constant VULPIX = 4;

    uint256 public constant BELLOSSOM = 5;

    uint256 public constant GLOOM = 6;

    uint256 public constant VILEPLUME = 7;

    uint256 public constant STARMIE = 8;

    uint256 public constant STARYU = 9;

    constructor(
        string memory _ipfsLocation
    ) 
        ERC1155(
            string(abi.encodePacked(_ipfsLocation, "{id}.json"))
        ) 
    {
        ipfsLocation = _ipfsLocation;

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintPokemon(
        address to, 
        uint256 id
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _mint(to, id, 1, "");
    }

    function burnPokemon(
        address from, 
        uint256 id
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _burn(from, id, 1);
    }

    function initialize(address target) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MANIPULATOR_ROLE, target);
    }

    function uri(
        uint256 _tokenId
    ) 
        override 
        public 
        view 
        returns (string memory) 
    {
        return string(
            abi.encodePacked(
                ipfsLocation, Strings.toString(_tokenId), ".json"
            )
        );
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
