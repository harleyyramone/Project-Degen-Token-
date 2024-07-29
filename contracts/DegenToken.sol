/*
Requirements:
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2. Transferring tokens: Players should be able to transfer their tokens to others.
3. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4. Checking token balance: Players should be able to check their token balance at any time.
5. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("DegenToken", "DGN") {}

    // Minting new tokens - only owner can mint
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Custom transfer function
    function sendTokens(address recipient, uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient DegenToken balance");
        _transfer(msg.sender, recipient, amount);
    }

    // Redeeming tokens for items
    function redeemItem(uint256 itemId) external {
        uint256[] memory itemCosts = new uint256[](5);
        itemCosts[0] = 20 * 10**decimals(); // Item 1: 20 tokens
        itemCosts[1] = 15 * 10**decimals(); // Item 2: 15 tokens
        itemCosts[2] = 10 * 10**decimals(); // Item 3: 10 tokens
        itemCosts[3] = 8 * 10**decimals();  // Item 4: 8 tokens
        itemCosts[4] = 5 * 10**decimals();  // Item 5: 5 tokens

        require(itemId > 0 && itemId <= itemCosts.length, "Invalid item ID");
        uint256 cost = itemCosts[itemId - 1];
        require(balanceOf(msg.sender) >= cost, "Insufficient DegenToken balance to redeem item");

        _burn(msg.sender, cost);
        emit ItemRedeemed(msg.sender, itemId, cost);
    }

    event ItemRedeemed(address indexed user, uint256 indexed itemId, uint256 cost);

    // Checking token balance
    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    // Burning tokens - already provided by ERC20Burnable
    function burnTokens(uint256 amount) external {
        burn(amount);
    }

    // List of redeemable items
    function listItems() external pure returns (string memory) {
        return "Available Items:\n1. Degen Hoodie\n2. Degen Cap\n3. Degen Notebook\n4. Degen Water Bottle\n5. Degen Keychain";
    }
}
