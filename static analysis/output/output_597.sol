pragma solidity ^0.8.9;
contract SimpleSafeV3 {
  address public owner;

  constructor() public payable {
    owner = payable(msg.sender);
  }
}

