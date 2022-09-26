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

    struct LevelEvolution {
        uint256 newId;
        uint256 price;
    }

    mapping(uint256 => mapping(uint256 => bool)) evolutionAvailable; // pokemonId -> evolution type -> bool

    mapping(uint256 => LevelEvolution) levelEvolutions;
    mapping(uint256 => uint256) thunderEvolutions;
    mapping(uint256 => uint256) iceEvolutions;
    mapping(uint256 => uint256) moonEvolutions;
    mapping(uint256 => uint256) fireEvolutions;


    constructor(
        string memory _ipfsLocation
    ) 
        ERC1155(
            string(abi.encodePacked(_ipfsLocation, "{id}.json"))
        ) 
    {
        ipfsLocation = _ipfsLocation;

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        modifyEvolution(PIKACHU, RAICHU, 0, 20);
        modifyEvolution(RAICHU, NINETALES, 0, 40);
        modifyEvolution(NINETALES, STARYU, 2, 1);
        modifyEvolution(STARYU, STARMIE, 4, 1);

        modifyEvolution(VULPIX, BELLOSSOM, 1, 1);
        modifyEvolution(BELLOSSOM, GLOOM, 0, 36);
        modifyEvolution(GLOOM, VILEPLUME, 3, 1);
        modifyEvolution(GLOOM, STARMIE, 4, 1);
    }

    function getEvolution(
        uint256 pokemonId, 
        uint256 assetId
    ) 
        external 
        view 
        returns (uint256, uint256) 
    {
        require(
            evolutionAvailable[pokemonId][assetId] == true, 
            "No available evolutions"
        );

        if (assetId == 0) {
            return (
                levelEvolutions[pokemonId].newId, 
                levelEvolutions[pokemonId].price
            );
        } else if (assetId == 1) {
            return (thunderEvolutions[pokemonId], 1);
        } else if (assetId == 2) {
            return (iceEvolutions[pokemonId], 1);
        } else if (assetId == 3) {
            return (moonEvolutions[pokemonId], 1);
        } else if (assetId == 4) {
            return (fireEvolutions[pokemonId], 1);
        } else {
            return (0, 0);
        }
    }

    function modifyEvolution(
        uint256 currentPokemonId, 
        uint256 newPokemonId,
        uint256 assetId, 
        uint256 price
    ) 
        public 
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
        require(
            currentPokemonId < 10 && 
            newPokemonId < 10 && 
            assetId < 5,
            "Wrong input data"
        );

        if (assetId == 0) {
            LevelEvolution storage l = levelEvolutions[currentPokemonId];
            l.newId = newPokemonId;
            l.price = price;
        } else if (assetId == 1) {
            thunderEvolutions[currentPokemonId] = newPokemonId;
        } else if (assetId == 2) {
            iceEvolutions[currentPokemonId] = newPokemonId;
        } else if (assetId == 3) {
            moonEvolutions[currentPokemonId] = newPokemonId;
        } else if (assetId == 4) {
            fireEvolutions[currentPokemonId] = newPokemonId;
        }
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

    function initialize(address target) 
        external 
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
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
