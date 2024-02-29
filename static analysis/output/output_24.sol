pragma solidity ^0.8.9;
contract Owned {
  address public owner;
  address public newOwner;

  event OwnershipTransferred(address indexed newOwner);

  constructor () {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    newOwner = msg.sender;
    emit OwnershipTransferred(newOwner);
  }
}

