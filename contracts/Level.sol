//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Level is ERC20, AccessControl {
    bytes32 public constant MANIPULATOR_ROLE = keccak256("MANIPULATOR_ROLE");

    constructor() ERC20("Level", "LVL") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mintLevel(address to, uint256 amount) external onlyRole(MANIPULATOR_ROLE) {
        _mint(to, amount);
    }

    function burnLevel(address from, uint256 amount) external onlyRole(MANIPULATOR_ROLE) {
        _burn(from, amount);
    }

    function initialize(address target) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _grantRole(MANIPULATOR_ROLE, target);
    }
}
