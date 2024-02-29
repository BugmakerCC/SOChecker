pragma solidity ^0.8.9;
contract Ownership {
  string public name;
  address public owner;

  constructor() public {
    name = "Ownership";
    owner = msg.sender;
  }

  function transferOwnership(address newowner) public {
    require(newowner != address(0));
    emit OwnershipTransferred(owner, newowner);
    owner = newowner;
  }

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
}

