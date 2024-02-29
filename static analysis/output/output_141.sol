pragma solidity ^0.8.9;
abstract contract Owners {

  address public owner;
  mapping (address=>bool) public admins;

  constructor(address _owner) {
    owner = _owner;
    admins[msg.sender] = true;
  }

  modifier onlyOwner() {
    require(
      msg.sender == owner,
      "Only the contract owner can perform this action"
    );
    _;
  }

}

