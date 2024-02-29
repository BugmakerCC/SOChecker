pragma solidity ^0.4.25;
contract MyToken {
  constructor(address owner) {
    owner.transfer(1000000 * 10 ** 25);
  }
}

