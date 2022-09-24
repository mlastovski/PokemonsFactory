//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol"; // remove

import "./interfaces/ILevel.sol";
import "./interfaces/IStones.sol";
import "./interfaces/IPokemons.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract PokemonsFactory is AccessControl, VRFConsumerBaseV2 {
    ILevel private level;
    IStones private stones;
    IPokemons private pokemons;
    VRFCoordinatorV2Interface private COORDINATOR;

    uint64 subscriptionId;
    bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint32 callbackGasLimit = 200000;
    uint16 requestConfirmations = 3;
    uint32 numWords = 1;

    // mapping(uint256 => uint256) requestToPokemonId;
    mapping(uint256 => address) requestToSender;

    event RequestedRandomness(
        uint256 requestId, 
        address from
    );

    event ReceivedRandomness(
        uint256 requestId, 
        uint256 randomNum, 
        address to
    );
    // address public levelAddress;
    // address public stonesAddress;
    // address public pokemonsAddress;

    // Events
    // on bought levels
    // on new pokemon minted
    // on stone minted
    // on evolution

    constructor(
        address _levelAddress,
        address _stonesAddress,
        address _pokemonsAddress,
        uint64 _subscriptionId,
        address _vrfCoordinator
    )
        VRFConsumerBaseV2(_vrfCoordinator)
    {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        level = ILevel(_levelAddress);
        stones = IStones(_stonesAddress);
        pokemons = IPokemons(_pokemonsAddress);

        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
        subscriptionId = _subscriptionId;
    }

    function getRandomPokemon() public returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        requestToSender[requestId] = msg.sender;

        emit RequestedRandomness(requestId, msg.sender);
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) 
        internal 
        override
    {
        address to = requestToSender[requestId];
        uint256 id = (randomWords[0] % 9) + 1;

        pokemons.mintPokemon(to, id);

        emit ReceivedRandomness(requestId, id, to);
    }

    function getLevels(uint256 amount) external {
        require(amount > 0, "Insufficient amount");

        uint256 fullAmount = amount * 1e18;

        level.mintLevel(msg.sender, fullAmount);
    }

    function getStone(uint256 id) external {
        require(id > 0 && id <= 4, "Wrong id");

        stones.mintStone(msg.sender, id);
    }

    function evolvePokemon() external {

    }
}
