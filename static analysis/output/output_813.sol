pragma solidity ^0.8.9;
contract Ownership {
    
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }

}

