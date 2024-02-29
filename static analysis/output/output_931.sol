pragma solidity ^0.8.9;
contract Ownable {
    address public owner;

    modifier ownerOnly() {
        require(msg.sender == owner,"Invalid caller");
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
}

