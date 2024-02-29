pragma solidity ^0.8.9;
contract Owned {
    address public owner;
    address public admin = msg.sender;

    constructor() public {
        owner = msg.sender;
        admin = msg.sender;
    }

    modifier isAdmin {
        require(admin == msg.sender,"you are not the owner");
        _;
    }
}

