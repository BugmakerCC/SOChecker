pragma solidity ^0.8.9;
contract TestContract1 {
 

 
 
}

contract TestContract2 {
   
  address owner;

    constructor() {
      owner = msg.sender;
    }

    function ownerOf() public view returns (bool) {
      return owner == msg.sender;
    }

    modifier onlyOwner() {
      require(owner == address(msg.sender));
      _;
    }
  }

