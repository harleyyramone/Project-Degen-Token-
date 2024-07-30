# Project-Degen-Token
Project-Degen-Token is a blockchain-based platform that aims to incorporate cryptocurrency tokens into gaming environments. The project uses the ERC-20 standard to produce a digital token called "DegenToken" (DGN), which players can earn, transfer, and redeem within the game. The platform allows the owner to create new tokens as prizes, and players can spend these tokens to buy in-game stuff, which improves their gaming experience. The project uses blockchain technology to provide safe and transparent transactions, establishing a strong and compelling gaming ecosystem.


## Description

The code for Project-Degen-Token is written in Solidity, and it extends the OpenZeppelin library to provide custom DegenToken functionality. The contract limits minting powers to the owner, ensuring regulated token distribution. Tokens may be transferred to others and redeemed for different in-game objects, with each redemption burning a certain number of tokens. The contract also allows users to verify their token balance and burn tokens that are no longer needed. Furthermore, the token's decimals are set to zero, making it non-divisible and easier to manage in the gaming environment. The programming implements these functionalities to build a smooth and safe token economy for the game.




## Getting Started

### Executing program

To execute this program, you may use Remix, an online Solidity IDE; to get started, go visit https://remix.ethereum.org/.

Once on the Remix website, click the "+" symbol in the left-hand sidebar to create a new file. Save the file as HelloWorld.sol. Copy and paste the code below into the file.

```javascript
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
        itemCosts[0] = 20; // Item 1: 20 tokens
        itemCosts[1] = 15; // Item 2: 15 tokens
        itemCosts[2] = 10; // Item 3: 10 tokens
        itemCosts[3] = 8;  // Item 4: 8 tokens
        itemCosts[4] = 5;  // Item 5: 5 tokens

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

      function decimals() override public pure returns (uint8) {
        return 0;
    }
}


```


To compile the code, select the "Solidity Compiler" tab from the left sidebar. Set the "Compiler" option to "0.8.18" (or any suitable version), then click the "Compile HelloWorld.sol" button.

Once the code has been built, you can deploy the contract by selecting the "Deploy & Run Transactions" tab in the left-hand sidebar. Choose the "HelloWorld" contract from the dropdown menu, and then click the "Deploy" button.

Once the contract has been deployed, you can interact with it by using the sayHello method. Click the "HelloWorld" contract in the left-hand sidebar, followed by the "sayHello" function. Finally, click the "transact" button to call the function and get the "Hello World!" message.
## Authors

Metacrafter Student Harley Ramone Tesorero
[@harleyramonee](https://twitter.com/harleyramonee)


## License

This project is licensed under the Harley Ramone Tesorero License - see the LICENSE.md file for details
