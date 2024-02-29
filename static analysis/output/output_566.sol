pragma solidity ^0.8.9;
contract A {
    string public name;
    address public owner;
    mapping(address => uint256) private amount;
  
    constructor(address payable owner_address) public {
      
        owner = owner_address;
        amount[owner_address] = 1 ether;
        name = "Ada";
    }
}

