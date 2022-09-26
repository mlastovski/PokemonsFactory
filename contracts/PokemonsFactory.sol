//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./interfaces/ILevel.sol";
import "./interfaces/IStones.sol";
import "./interfaces/IPokemons.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

/// @title PokemonsFactory project's main contract.
/// @author mlastovski
contract PokemonsFactory is AccessControl, VRFConsumerBaseV2 {
    /// @dev Level (ERC-20 token) instance.
    ILevel private level;

    /// @dev Stones (ERC-1155 token) instance.
    IStones private stones;

    /// @dev Pokemons (ERC-1155 token) instance.
    IPokemons private pokemons;

    /// @dev VRFCoordinatorV2 instance.
    VRFCoordinatorV2Interface private COORDINATOR;

    /// @dev How many confirmations the Chainlink node 
    ///      should wait before responding.
    uint16 requestConfirmations = 3;

    /// @dev The limit for how much gas to use for the callback 
    ///      request to `fulfillRandomWords` function.
    uint32 callbackGasLimit = 200000;

    /// @dev How many random values to request.
    uint32 numWords = 1;

    /// @dev The subscription ID that this contract uses for funding requests. 
    ///      Initialized in the `constructor`.
    uint64 subscriptionId;

    /// @dev The gas lane key hash value, which is the maximum gas price 
    ///      you are willing to pay for a request in wei. 
    bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;

    /// @dev Maps request id to the caller's address. 
    ///      Set to public for transparency purposes. 
    mapping(uint256 => address) public requestToSender;

    /// @dev Emits on `getRandomPokemon` function call.
    event RequestedRandomness(
        uint256 requestId, 
        address from
    );

    /// @dev Emits on `fulfillRandomWords` function call.
    event ReceivedRandomness(
        uint256 requestId, 
        uint256 randomNum, 
        address to
    );

    /// @dev Emits on `getLevels` function call.
    event LevelsBought(
        address buyer,
        uint256 amount
    );

    /// @dev Emits on `getStone` function call.
    event StoneBought(
        address buyer,
        uint256 id
    );

    /// @dev Emits on `evolvePokemon` function call.
    event PokemonEvolved(
        address owner,
        uint256 oldPokemonId,
        uint256 newPokemonId, 
        uint256 assetUsed
    );

    /// @dev Grants an admin role to the contract creator. 
    ///      Assigns contract adresses to their instances.
    /// @param _levelAddress Level (ERC-20 token) contract address.
    /// @param _stonesAddress Stones (ERC-1155 token) contract address.
    /// @param _pokemonsAddress Pokemons (ERC-1155 token) contract address.
    /// @param _subscriptionId Chainlink subscription ID.
    /// @param _vrfCoordinator VRF Coordinator contract address.
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

    /// @notice Mints a random Pokemon.
    /// @dev Returns the request ID which is sent to the Coordinator contract.
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

    /// @dev The actual mint of the Pokemon. 
    ///      Invoked by the Coordinator. 
    ///      Receives the requestId and randomWords array. 
    /// @param requestId The same request ID obtained from `getRandomPokemon` function.
    /// @param randomWords The requested random number.
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

    /// @notice Mints `amount` of levels to caller's address.
    /// @param amount Amount of Level tokens to mint.
    function getLevels(uint256 amount) external {
        require(amount > 0, "Insufficient amount");

        uint256 fullAmount = amount * 1e18;
        level.mintLevel(msg.sender, fullAmount);

        emit LevelsBought(msg.sender, fullAmount);
    }

    /// @notice Mints the selected Stone token by `id` to caller's address.
    /// @param id Stone id. 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE.
    function getStone(uint256 id) external {
        require(id > 0 && id <= 4, "Wrong id");

        stones.mintStone(msg.sender, id);

        emit StoneBought(msg.sender, id);
    }

    /// @notice Evolves your Pokemon.
    /// @dev Checks if evolution by given `currentPokemonId` & `assetId` exists. 
    ///      If price is greater than 1 -> This is an evolution via Level token.
    ///      If price is equal to 1 -> This is an evolution via Stone token. 
    ///      Price is always greater than zero. Burns your current Pokemon token 
    ///      as well as the asset token provided for the evolution. Mints a new Pokemon token.   
    /// @param currentPokemonId Id of the Pokemon token that you own.
    /// @param assetId Id of the asset token you want to spend for the evolution.        
    function evolvePokemon(
        uint256 currentPokemonId, 
        uint256 assetId
    ) 
        external 
    {
        (uint256 newId, uint256 price) = pokemons.getEvolution(
            currentPokemonId, 
            assetId
        );

        price > 1 
            ? level.burnLevel(msg.sender, price) 
            : stones.burnStone(msg.sender, assetId);
        
        pokemons.burnPokemon(msg.sender, currentPokemonId);
        pokemons.mintPokemon(msg.sender, newId);

        emit PokemonEvolved(
            msg.sender, 
            currentPokemonId, 
            newId, 
            assetId
        );
    }
}
