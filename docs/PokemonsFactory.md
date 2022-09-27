# PokemonsFactory

*mlastovski*

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

### getStone

```solidity
function getStone(uint256 id) external nonpayable
```

Mints the selected Stone token by `id` to caller&#39;s address.



#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | Stone id. 1 = THUNDER, 2 = ICE, 3 = MOON, 4 = FIRE. |

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

### rawFulfillRandomWords

```solidity
function rawFulfillRandomWords(uint256 requestId, uint256[] randomWords) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint256 | undefined |
| randomWords | uint256[] | undefined |

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



## Errors

### OnlyCoordinatorCanFulfill

```solidity
error OnlyCoordinatorCanFulfill(address have, address want)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | address | undefined |
| want | address | undefined |


