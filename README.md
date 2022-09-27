# ☢️ Pokemons Factory

# Description

Pokemons Factory is an NFT sandbox. I created this project as a test task for a solidity smart contract junior developer position. This is an example for me of how to implement in-game currency and cosmetics/collectibles with fungible & non-fungible tokens.

With this project you can mint yourself a random Pokemon and evolve it using one of the required assets if you want obviously :)

## Features

- All smart contracts are verified on Polygonscan Mumbai:
    - [Level.sol](https://mumbai.polygonscan.com/address/0xf15cc36e2e775af950d4e8db0e61d468afdf1e6b#code)
    - [Stones.sol](https://mumbai.polygonscan.com/address/0xf9e88a1503a64e24ae9db3d01056a26747e2b718#code)
    - [Pokemons.sol](https://mumbai.polygonscan.com/address/0x4986e1ad56e1580b70877140b865f45e5af03ebe#code)
    - [PokemonsFactory.sol](https://mumbai.polygonscan.com/address/0xa39902c5ccd3165c178394b62ffb0470384970c9#code)
- Each contract has a comprehensive NatSpec documentation.
- Deployment scripts for each contract are stored in scripts/.
- Unit tests with 100% solidity-coverage are located in test/.
- Function `getRandomPokemon()` in `PokemonsFactory.sol` allows you to mint a Pokemon with true randomness, thanks to Chainlink :)

# Contracts

## Level.sol

> An ERC-20 compliant token with some custom functionality.





## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```

*Default admin role. Assigned to the contract creator on deployment.*


### MANIPULATOR_ROLE

```solidity
function MANIPULATOR_ROLE() external view returns (bytes32)
```



*Role that will be able to call `mintLevel` and `burnLevel`.*


### burnLevel

```solidity
function burnLevel(address from, uint256 amount) external nonpayable
```



*Burn `amount` of tokens from the address `from`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | Address to burn tokens from. |
| amount | uint256 | Amount of tokens to burn. |

### initialize

```solidity
function initialize(address target) external nonpayable
```



*Grants role `MANIPULATOR_ROLE` to the address `target`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| target | address | Address to give role to. |

### mintLevel

```solidity
function mintLevel(address to, uint256 amount) external nonpayable
```



*Mint `amount` of tokens to the address `to`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | Address to mint tokens to. |
| amount | uint256 | Amount of tokens to mint. |

## Stones.sol

> An ERC-1155 compliant token for the PokemonsFactory project.





## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






### MANIPULATOR_ROLE

```solidity
function MANIPULATOR_ROLE() external view returns (bytes32)
```



*Role that will be able to call `mintStone` and `burnStone`.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### burnStone

```solidity
function burnStone(address from, uint256 id) external nonpayable
```



*Burn tokens from `id` collection from the address `from`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | Address to burn tokens from. |
| id | uint256 | Id of the collection. |

### initialize

```solidity
function initialize(address target) external nonpayable
```



*Grants role `MANIPULATOR_ROLE` to the address `target`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| target | address | Address to give role to. |

### ipfsLocation

```solidity
function ipfsLocation() external view returns (string)
```



*A string with the IPFS location of token assets.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### mintStone

```solidity
function mintStone(address to, uint256 id) external nonpayable
```



*Mint tokens from `id` collection to the address `to`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | Address to mint tokens to. |
| id | uint256 | Id of the collection. |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*Used to resolve the conflict when inheriting from both      AccessControl and ERC1155.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### symbol

```solidity
function symbol() external view returns (string)
```



*Symbol of the collection (assigned to correctly display on OpenSea).*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### uri

```solidity
function uri(uint256 _tokenId) external view returns (string)
```

Sets NFT matadata (e.g. for OpenSea).



#### Parameters

| Name | Type | Description |
|---|---|---|
| _tokenId | uint256 | Token&#39;s ID. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | A string with NFT metadata.  |



### name


```solidity
function name() external view returns (string)
```



*Name of the collection (assigned to correctly display on OpenSea).*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |




## Pokemons.sol


> An ERC-1155 compliant token for the PokemonsFactory project.





## Methods

### BELLOSSOM

```solidity
function BELLOSSOM() external view returns (uint8)
```



*5th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### GLOOM

```solidity
function GLOOM() external view returns (uint8)
```



*6th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### MANIPULATOR_ROLE

```solidity
function MANIPULATOR_ROLE() external view returns (bytes32)
```



*Role that will be able to call `mintPokemon` and `burnPokemon`.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### NINETALES

```solidity
function NINETALES() external view returns (uint8)
```



*3rd collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### PIKACHU

```solidity
function PIKACHU() external view returns (uint8)
```



*1st collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### RAICHU

```solidity
function RAICHU() external view returns (uint8)
```



*2nd collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### STARMIE

```solidity
function STARMIE() external view returns (uint8)
```



*8th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### STARYU

```solidity
function STARYU() external view returns (uint8)
```



*9th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### VILEPLUME

```solidity
function VILEPLUME() external view returns (uint8)
```



*7th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### VULPIX

```solidity
function VULPIX() external view returns (uint8)
```



*4th collection*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined |

### burnPokemon

```solidity
function burnPokemon(address from, uint256 id) external nonpayable
```



*Burn tokens from `id` collection from the address `from`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | Address to burn tokens from. |
| id | uint256 | Id of the collection. |

### fireEvolutions

```solidity
function fireEvolutions(uint256) external view returns (uint256)
```



*Pokemon Id -&gt; New pokemon Id after the evolution via FIRE stone. *

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getEvolution

```solidity
function getEvolution(uint256 pokemonId, uint256 assetId) external view returns (uint256, uint256)
```



*Returns new Pokemon Id and price asked for evolution. `assetId` options: 0 = Level, 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| pokemonId | uint256 | Pokemon Id to check. |
| assetId | uint256 | Id of the asset which will be used for the evolution.   |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |
| _1 | uint256 | undefined |

### iceEvolutions

```solidity
function iceEvolutions(uint256) external view returns (uint256)
```



*Pokemon Id -&gt; New pokemon Id after the evolution via ICE stone. *

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### initialize

```solidity
function initialize(address target) external nonpayable
```



*Grants role `MANIPULATOR_ROLE` to the address `target`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| target | address | Address to give role to. |

### ipfsLocation

```solidity
function ipfsLocation() external view returns (string)
```



*A string with the IPFS location of token assets.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### levelEvolutions

```solidity
function levelEvolutions(uint256) external view returns (uint256 newId, uint256 price)
```



*Pokemon Id -&gt; `LevelEvolution` struct.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| newId | uint256 | undefined |
| price | uint256 | undefined |

### mintPokemon

```solidity
function mintPokemon(address to, uint256 id) external nonpayable
```



*Mint tokens from `id` collection to the address `to`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | Address to mint tokens to. |
| id | uint256 | Id of the collection. |

### modifyEvolution

```solidity
function modifyEvolution(uint256 currentPokemonId, uint256 newPokemonId, uint256 assetId, uint256 price) external nonpayable
```



*Function to change 1 evolution option. Admin only. `assetId` options: 0 = Level, 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| currentPokemonId | uint256 | Pokemon Id to evolve from. |
| newPokemonId | uint256 | Pokemon Id to evolve to. |
| assetId | uint256 | Id of the asset which will be used for the evolution.   |
| price | uint256 | Price in Levels. Mandatory only if the evolution is meant to be set in levels. |

### moonEvolutions

```solidity
function moonEvolutions(uint256) external view returns (uint256)
```



*Pokemon Id -&gt; New pokemon Id after the evolution via MOON stone. *

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### name

```solidity
function name() external view returns (string)
```



*Name of the collection (assigned to correctly display on OpenSea).*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*Used to resolve the conflict when inheriting from both      AccessControl and ERC1155.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### symbol

```solidity
function symbol() external view returns (string)
```



*Symbol of the collection (assigned to correctly display on OpenSea).*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### thunderEvolutions

```solidity
function thunderEvolutions(uint256) external view returns (uint256)
```



*Pokemon Id -&gt; New pokemon Id after the evolution via THUNDER stone. *

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### uri

```solidity
function uri(uint256 _tokenId) external view returns (string)
```

Sets NFT matadata (e.g. for OpenSea).



#### Parameters

| Name | Type | Description |
|---|---|---|
| _tokenId | uint256 | Token&#39;s ID. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | A string with NFT metadata.  |



## PokemonsFactory.sol


> PokemonsFactory project&#39;s main contract.





## Methods

### DEFAULT_ADMIN_ROLE

```solidity
function DEFAULT_ADMIN_ROLE() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### evolvePokemon

```solidity
function evolvePokemon(uint256 currentPokemonId, uint256 assetId) external nonpayable
```

Evolves your Pokemon.

*Checks if evolution by given `currentPokemonId` &amp; `assetId` exists.       If price is greater than 1 -&gt; This is an evolution via Level token.      If price is equal to 1 -&gt; This is an evolution via Stone token.       Price is always greater than zero. Burns your current Pokemon token       as well as the asset token provided for the evolution. Mints a new Pokemon token.   *

#### Parameters

| Name | Type | Description |
|---|---|---|
| currentPokemonId | uint256 | Id of the Pokemon token that you own. |
| assetId | uint256 | Id of the asset token you want to spend for the evolution.         |

### getLevels

```solidity
function getLevels(uint256 amount) external nonpayable
```

Mints `amount` of levels to caller&#39;s address.



#### Parameters

| Name | Type | Description |
|---|---|---|
| amount | uint256 | Amount of Level tokens to mint. |

### getRandomPokemon

```solidity
function getRandomPokemon() external nonpayable returns (uint256 requestId)
```

Mints a random Pokemon.

*Returns the request ID which is sent to the Coordinator contract.*


#### Returns

| Name | Type | Description |
|---|---|---|
| requestId | uint256 | undefined |

### getStone

```solidity
function getStone(uint256 id) external nonpayable
```

Mints the selected Stone token by `id` to caller&#39;s address.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | Stone id. 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE. |

### requestToSender

```solidity
function requestToSender(uint256) external view returns (address)
```



*Maps request id to the caller&#39;s address.       Set to public for transparency purposes. *

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |



## Events

### LevelsBought

```solidity
event LevelsBought(address buyer, uint256 amount)
```



*Emits on `getLevels` function call.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| buyer  | address | undefined |
| amount  | uint256 | undefined |

### PokemonEvolved

```solidity
event PokemonEvolved(address owner, uint256 oldPokemonId, uint256 newPokemonId, uint256 assetUsed)
```



*Emits on `evolvePokemon` function call.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner  | address | undefined |
| oldPokemonId  | uint256 | undefined |
| newPokemonId  | uint256 | undefined |
| assetUsed  | uint256 | undefined |

### ReceivedRandomness

```solidity
event ReceivedRandomness(uint256 requestId, uint256 randomNum, address to)
```



*Emits on `fulfillRandomWords` function call.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId  | uint256 | undefined |
| randomNum  | uint256 | undefined |
| to  | address | undefined |

### RequestedRandomness

```solidity
event RequestedRandomness(uint256 requestId, address from)
```



*Emits on `getRandomPokemon` function call.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId  | uint256 | undefined |
| from  | address | undefined |

### StoneBought

```solidity
event StoneBought(address buyer, uint256 id)
```



*Emits on `getStone` function call.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| buyer  | address | undefined |
| id  | uint256 | undefined |



