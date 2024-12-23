// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Counter Contract
/// @notice A simple counter contract to demonstrate minitng NFT functionality.
/// @custom:dev-run-script ./scripts/web3-lib.ts

contract NFTMinting {
    address public owner; // Contract owner
    address public constant receiver = 0x6aff005029144bF423F5F6FCbe797626c30ed498; // Receiver's wallet address
    uint256 public mintingFee = 0.2 ether; // Fixed minting fee

    event Mint(address indexed user, uint256 amount);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // Function to mint an NFT
    function mint() public payable {
        require(msg.value == mintingFee, "Incorrect fee sent");
        require(receiver != address(0), "Receiver address not set");

        // Transfer the minting fee to the receiver address
        payable(receiver).transfer(msg.value);

        emit Mint(msg.sender, msg.value);
    }

    // Function to update the minting fee (only owner)
    function setMintingFee(uint256 _newFee) public {
        require(msg.sender == owner, "Only owner can update the fee");
        mintingFee = _newFee;
    }
}
