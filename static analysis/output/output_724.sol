pragma solidity ^0.8.9;
contract MintWallet {

    string public name;

    address public owner;

    uint256 public maxPerWallet;

    mapping(address => uint256) public walletMints;

    constructor() public {
        owner = msg.sender;
        name = "Mint Wallet";
        maxPerWallet = 1 ether;
    }

    function mint(uint256 quantity_) public payable {
        walletMints[msg.sender] += quantity_;
        require(walletMints[msg.sender] <= maxPerWallet, "exceed max wallet");
    }
}

