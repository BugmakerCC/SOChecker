pragma solidity ^0.5.16;
contract Ownable {
  address payable public owner;

  
  constructor () public {
    owner = msg.sender;
  }

  
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}

