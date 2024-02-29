contract Target {
  uint256 public lastCalledAtBlockNumber;

  function foo() external {
    lastCalledAtBlockNumber = block.number;
  }
}

bytes32 blockHash = blockhash(block.number);


