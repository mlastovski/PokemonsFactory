# ☢️ Pokemons Factory

# Description

Pokemons Factory is an NFT sandbox. I created this project as a test task for a solidity smart contract junior developer position. This is an example for me of how to implement in-game currency and cosmetics/collectibles with fungible & non-fungible tokens.

With this project you can mint yourself a random Pokemon and evolve it using one of the required assets if you want obviously :)

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


