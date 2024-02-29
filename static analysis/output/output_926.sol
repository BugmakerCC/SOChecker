pragma solidity ^0.8.9;
contract Manager {
  address private manager;
  
  constructor() {
    manager = msg.sender;    
  }
  
  modifier onlyManager() {
    require(msg.sender == manager);
    _;
  }
}

