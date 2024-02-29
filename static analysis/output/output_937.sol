pragma solidity ^0.8;

contract MyContract {
    mapping(address => bool) public myMap;
    
    constructor() {
        myMap[address(0x123)] = true;
        myMap[address(0x456)] = false;
        myMap[address(0x789)] = true;
    }
}

