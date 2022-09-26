//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/// @title An ERC-1155 compliant token for the PokemonsFactory project.
/// @author mlastovski
contract Stones is ERC1155, AccessControl {
    /// @dev Role that will be able to call `mintStone` and `burnStone`.
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    /// @dev A string with the IPFS location of token assets.
    string public ipfsLocation;

    /// @dev Name of the collection (assigned to correctly display on OpenSea).
    string public name = "Stones";

    /// @dev Symbol of the collection (assigned to correctly display on OpenSea).
    string public symbol = "STNS";

    /// @dev Grants an admin role to the contract creator.
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
    }

    /// @dev Mint tokens from `id` collection to the address `to`.
    /// @param to Address to mint tokens to.
    /// @param id Id of the collection.
    function mintStone(
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
    function burnStone(
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
    function initialize(
        address target
    ) 
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
