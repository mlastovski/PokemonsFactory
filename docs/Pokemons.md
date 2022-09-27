# Pokemons

*mlastovski*

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

### balanceOf

```solidity
function balanceOf(address account, uint256 id) external view returns (uint256)
```



*See {IERC1155-balanceOf}. Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| id | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### balanceOfBatch

```solidity
function balanceOfBatch(address[] accounts, uint256[] ids) external view returns (uint256[])
```



*See {IERC1155-balanceOfBatch}. Requirements: - `accounts` and `ids` must have the same length.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| accounts | address[] | undefined |
| ids | uint256[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

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

### getRoleAdmin

```solidity
function getRoleAdmin(bytes32 role) external view returns (bytes32)
```



*Returns the admin role that controls `role`. See {grantRole} and {revokeRole}. To change a role&#39;s admin, use {_setRoleAdmin}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### grantRole

```solidity
function grantRole(bytes32 role, address account) external nonpayable
```



*Grants `role` to `account`. If `account` had not been already granted `role`, emits a {RoleGranted} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleGranted} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### hasRole

```solidity
function hasRole(bytes32 role, address account) external view returns (bool)
```



*Returns `true` if `account` has been granted `role`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

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

### isApprovedForAll

```solidity
function isApprovedForAll(address account, address operator) external view returns (bool)
```



*See {IERC1155-isApprovedForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| operator | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

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

### renounceRole

```solidity
function renounceRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from the calling account. Roles are often managed via {grantRole} and {revokeRole}: this function&#39;s purpose is to provide a mechanism for accounts to lose their privileges if they are compromised (such as when a trusted device is misplaced). If the calling account had been revoked `role`, emits a {RoleRevoked} event. Requirements: - the caller must be `account`. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### revokeRole

```solidity
function revokeRole(bytes32 role, address account) external nonpayable
```



*Revokes `role` from `account`. If `account` had been granted `role`, emits a {RoleRevoked} event. Requirements: - the caller must have ``role``&#39;s admin role. May emit a {RoleRevoked} event.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| role | bytes32 | undefined |
| account | address | undefined |

### safeBatchTransferFrom

```solidity
function safeBatchTransferFrom(address from, address to, uint256[] ids, uint256[] amounts, bytes data) external nonpayable
```



*See {IERC1155-safeBatchTransferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| ids | uint256[] | undefined |
| amounts | uint256[] | undefined |
| data | bytes | undefined |

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes data) external nonpayable
```



*See {IERC1155-safeTransferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| id | uint256 | undefined |
| amount | uint256 | undefined |
| data | bytes | undefined |

### setApprovalForAll

```solidity
function setApprovalForAll(address operator, bool approved) external nonpayable
```



*See {IERC1155-setApprovalForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | undefined |
| approved | bool | undefined |

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



## Events

### ApprovalForAll

```solidity
event ApprovalForAll(address indexed account, address indexed operator, bool approved)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account `indexed` | address | undefined |
| operator `indexed` | address | undefined |
| approved  | bool | undefined |

### RoleAdminChanged

```solidity
event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| previousAdminRole `indexed` | bytes32 | undefined |
| newAdminRole `indexed` | bytes32 | undefined |

### RoleGranted

```solidity
event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### RoleRevoked

```solidity
event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| role `indexed` | bytes32 | undefined |
| account `indexed` | address | undefined |
| sender `indexed` | address | undefined |

### TransferBatch

```solidity
event TransferBatch(address indexed operator, address indexed from, address indexed to, uint256[] ids, uint256[] values)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| ids  | uint256[] | undefined |
| values  | uint256[] | undefined |

### TransferSingle

```solidity
event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| id  | uint256 | undefined |
| value  | uint256 | undefined |

### URI

```solidity
event URI(string value, uint256 indexed id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| value  | string | undefined |
| id `indexed` | uint256 | undefined |



