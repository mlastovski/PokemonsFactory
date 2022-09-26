//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/// @title An ERC-20 compliant token for the PokemonsFactory project.
/// @author mlastovski
contract Level is ERC20, AccessControl {
    /// @dev Role that will be able to call `mintLevel` and `burnLevel`.
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    /// @dev Grants an admin role to the contract creator.
    constructor() ERC20("Level", "LVL") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /// @dev Mint `amount` of tokens to the address `to`.
    /// @param to Address to mint tokens to.
    /// @param amount Amount of tokens to mint.
    function mintLevel(
        address to, 
        uint256 amount
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _mint(to, amount);
    }

    /// @dev Burn `amount` of tokens from the address `from`.
    /// @param from Address to burn tokens from.
    /// @param amount Amount of tokens to burn.
    function burnLevel(
        address from, 
        uint256 amount
    ) 
        external 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _burn(from, amount);
    }

    /// @dev Grants role `MANIPULATOR_ROLE` to the address `target`.
    /// @param target Address to give role to.
    function initialize(
        address target
    ) 
        external 
        onlyRole(DEFAULT_ADMIN_ROLE) 
    {
        _grantRole(MANIPULATOR_ROLE, target);
    }
}
