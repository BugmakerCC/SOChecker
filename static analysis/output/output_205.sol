pragma solidity ^0.8.9;
abstract contract Ownable {
  address internal owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner, "Ownable: caller is not the owner");
    _;
  }

  function setOwner(address newOwner) public onlyOwner {
    owner = newOwner;
  }
}

