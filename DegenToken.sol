// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Import the ERC20 contract from OpenZeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 

// Define the contract for the token, inheriting from ERC20
contract Degen is ERC20 {
    address public owner;

    // Events to log transfers, burns, and rewards
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Redeem(address indexed player, uint256 value);

    // Constructor to initialize the token with name "Degen", symbol "DGN" and initial supply
    constructor(uint256 _initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, _initialSupply); // Mint initial supply to the deployer
        owner = msg.sender; // Set the owner as the deployer
    }

    // Modifier to restrict certain actions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    // Minting function, only callable by the owner
    function mint(address to, uint256 amount) public onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        _mint(to, amount); // Mint new tokens to the recipient
        emit Mint(to, amount); // Log the minting event
    }

    // Transfer function (ERC-20 standard)
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount must be greater than zero");
        return super.transfer(recipient, amount); // Transfer tokens using ERC-20 transfer
    }

    // Redeem tokens for items in the game store (placeholder for actual logic)
    function redeem(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to redeem");

        // Placeholder for the actual item redemption logic (e.g., deducting from in-game store)
        _burn(msg.sender, amount); // Burn the tokens once redeemed
        emit Redeem(msg.sender, amount); // Log the redeeming event
    }

    // Burn function, allows anyone to burn their own tokens
    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn");
        _burn(msg.sender, amount); // Burn tokens from the sender
        emit Burn(msg.sender, amount); // Log the burn event
    }

    // Check token balance (inherited from ERC20, but you can access directly using balanceOf function)
    // Example: balanceOf(msg.sender) will give the balance of the caller's address

    // Optional function to transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
    }
}
