pragma solidity ^0.8.9;
contract Token {

  constructor() {
    emit NewTokensMinted(msg.sender, 10000000000000000000000000);
  }

  event NewTokensMinted(address indexed to, uint256 amount);
}

