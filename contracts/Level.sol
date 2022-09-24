//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Level is ERC20, AccessControl {
    uint256 private currentPrice;

    event Bought(
        address buyer,
        uint256 amount
    );

    event PriceUpdated(
        uint256 newPrice,
        uint256 timestamp
    );

    event Withdrawal(
        address owner,
        uint256 indexed amount
    );

    constructor(uint256 _initialPrice) ERC20("Level", "LVL") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);

        currentPrice = _initialPrice;
    }

    function buy() external payable {
        require(
            msg.value >= currentPrice, 
            "LVL: Insufficient ETH amount"
        );

        uint256 amount = ((msg.value * 1e18) / currentPrice);

        _mint(msg.sender, amount);

        emit Bought(msg.sender, amount);
    }

    function updatePrice(uint256 price) external onlyRole(DEFAULT_ADMIN_ROLE) {
        currentPrice = price;

        emit PriceUpdated(currentPrice, block.timestamp);
    }

    function withdraw() external onlyRole(DEFAULT_ADMIN_ROLE) {
        payable(msg.sender).transfer(address(this).balance);

        emit Withdrawal(msg.sender, address(this).balance);
    }

    function getPrice() external view returns (uint256) {
        return currentPrice;
    }
}
