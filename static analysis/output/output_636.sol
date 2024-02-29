pragma solidity ^0.4.25;
contract Ownable {
  modifier onlyOwner() {
    require(msg.sender == owner, "Ownable: caller is not the owner");
    _;
  }

  function Ownable() payable public {}

  address private owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0), "Ownable: new owner cannot be the zero address");
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

