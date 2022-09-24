//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Stones is ERC1155, AccessControl {
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    string public ipfsLocation;

    string public name = "Stones";

    string public symbol = "STNS";

    uint256 public constant THUNDER = 1;

    uint256 public constant ICE = 2;

    uint256 public constant MOON = 3;

    uint256 public constant FIRE = 4;

    constructor(
        string memory _ipfsLocation
    ) 
        ERC1155(
            string(abi.encodePacked(_ipfsLocation, "{id}.json"))
        ) 
    {
        ipfsLocation = _ipfsLocation;

        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MANIPULATOR_ROLE, msg.sender);
    }

    function mintStone(
        address to, 
        uint256 id, 
        uint256 amount
    ) 
        internal 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _mint(to, id, amount, "");
    }

    function burnStone(
        address from, 
        uint256 id, 
        uint256 amount
    ) 
        internal 
        onlyRole(MANIPULATOR_ROLE) 
    {
        _burn(from, id, amount);
    }

    function initialize(address target) external onlyRole(DEFAULT_ADMIN_ROLE) {
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
