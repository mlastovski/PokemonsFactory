//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/// @title An ERC-1155 compliant token for the PokemonsFactory project.
/// @author mlastovski
contract Pokemons is ERC1155, AccessControl {
    /// @dev Role that will be able to call `mintPokemon` and `burnPokemon`.
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    /// @dev 1st collection
    uint8 public constant PIKACHU = 1;

    /// @dev 2nd collection
    uint8 public constant RAICHU = 2;

    /// @dev 3rd collection
    uint8 public constant NINETALES = 3;

    /// @dev 4th collection
    uint8 public constant VULPIX = 4;

    /// @dev 5th collection
    uint8 public constant BELLOSSOM = 5;

    /// @dev 6th collection
    uint8 public constant GLOOM = 6;

    /// @dev 7th collection
    uint8 public constant VILEPLUME = 7;

    /// @dev 8th collection
    uint8 public constant STARMIE = 8;

    /// @dev 9th collection
    uint8 public constant STARYU = 9;

    /// @dev A string with the IPFS location of token assets.
    string public ipfsLocation;

    /// @dev Name of the collection (assigned to correctly display on OpenSea).
    string public name = "Pokemons";

    /// @dev Symbol of the collection (assigned to correctly display on OpenSea).
    string public symbol = "PKMNS";

    /// @dev Struct used in `levelEvolutions` mapping.
    struct LevelEvolution {
        uint256 newId;
        uint256 price;
    }

    /// @dev List that proves if the evolution exists (Pokemon Id -> Evolution type -> Bool).
    mapping(uint256 => mapping(uint256 => bool)) evolutionAvailable; 

    /// @dev Pokemon Id -> `LevelEvolution` struct.
    mapping(uint256 => LevelEvolution) levelEvolutions;

    /// @dev Pokemon Id -> New pokemon Id after the evolution via THUNDER stone. 
    mapping(uint256 => uint256) thunderEvolutions;

    /// @dev Pokemon Id -> New pokemon Id after the evolution via ICE stone. 
    mapping(uint256 => uint256) iceEvolutions;

    /// @dev Pokemon Id -> New pokemon Id after the evolution via MOON stone. 
    mapping(uint256 => uint256) moonEvolutions;

    /// @dev Pokemon Id -> New pokemon Id after the evolution via FIRE stone. 
    mapping(uint256 => uint256) fireEvolutions;

    /// @dev Grants an admin role to the contract creator. Creates evolution options.
    /// @param _ipfsLocation A string with the IPFS location of token assets.
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

    /// @dev Returns new Pokemon Id and price asked for evolution.
    /// `assetId` options: 0 = Level, 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE.
    /// @param pokemonId Pokemon Id to check.
    /// @param assetId Id of the asset which will be used for the evolution.  
    function getEvolution(
        uint256 pokemonId, 
        uint256 assetId
    ) 
        external 
        view 
        returns (uint256, uint256) 
    {
        require(
            evolutionAvailable[pokemonId][assetId] && assetId < 5, 
            "Pokemons: no available evolutions"
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
        } else {
            return (fireEvolutions[pokemonId], 1);
        }
    }

    /// @dev Function to change 1 evolution option. Admin only.
    /// `assetId` options: 0 = Level, 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE.
    /// @param currentPokemonId Pokemon Id to evolve from.
    /// @param newPokemonId Pokemon Id to evolve to.
    /// @param assetId Id of the asset which will be used for the evolution.  
    /// @param price Price in Levels. Mandatory only if the evolution is meant to be set in levels.
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
            "Pokemons: wrong input data"
        );

        if (assetId == 0) {
            LevelEvolution storage l = levelEvolutions[currentPokemonId];
            l.newId = newPokemonId;
            l.price = price * 1e18;
        } else if (assetId == 1) {
            thunderEvolutions[currentPokemonId] = newPokemonId;
        } else if (assetId == 2) {
            iceEvolutions[currentPokemonId] = newPokemonId;
        } else if (assetId == 3) {
            moonEvolutions[currentPokemonId] = newPokemonId;
        } else {
            fireEvolutions[currentPokemonId] = newPokemonId;
        }

        evolutionAvailable[currentPokemonId][assetId] = true;
    }

    /// @dev Mint tokens from `id` collection to the address `to`.
    /// @param to Address to mint tokens to.
    /// @param id Id of the collection.
    function mintPokemon(
        address to, 
        uint256 id
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _mint(to, id, 1, "");
    }

    /// @dev Burn tokens from `id` collection from the address `from`.
    /// @param from Address to burn tokens from.
    /// @param id Id of the collection.
    function burnPokemon(
        address from, 
        uint256 id
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _burn(from, id, 1);
    }

    /// @dev Grants role `MANIPULATOR_ROLE` to the address `target`.
    /// @param target Address to give role to.
    function initialize(address target) 
        external 
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
        _grantRole(MANIPULATOR_ROLE, target);
    }

    /// @notice Sets NFT matadata (e.g. for OpenSea).
    /// @param _tokenId Token's ID.
    /// @return A string with NFT metadata. 
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

    /// @dev Used to resolve the conflict when inheriting from both
    ///      AccessControl and ERC1155.
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
