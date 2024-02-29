pragma solidity ^0.8.9;
contract Ownable {

  address private owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender==owner);
    _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    owner = newOwner;
  }

  function isOwner() external view returns (bool) {
    return msg.sender==owner;
  }
}

contract ReentrancyGuard {

  bool private _notEntered;

  constructor() {
    _notEntered = true;
  }

  modifier notEntered() {
    require(!_notEntered);
    _;
    _notEntered = true;
  }

  modifier entered() {
    require(_notEntered);
    _;
    _notEntered = false;
  }
}

