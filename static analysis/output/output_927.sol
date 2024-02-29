pragma solidity ^0.8.9;
contract Target {
  uint256 public lastCalledAtBlockNumber;

  function foo() external {
    lastCalledAtBlockNumber = block.number;
  }
}

