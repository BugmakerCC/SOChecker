pragma solidity ^0.8.9;
contract Ownership {
    address public owner;
    
    constructor () {
        owner = msg.sender;
    }
}

