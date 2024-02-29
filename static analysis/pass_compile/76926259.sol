contract Test {
    uint public blockNumber;
    bytes32 public blockHashNow;
    bytes32 public blockHashPrevious;

    function setValues() {
        blockNumber = block.number;
        blockHashNow = block.blockhash(blockNumber);
        blockHashPrevious = block.blockhash(blockNumber - 1);
    }    
}

