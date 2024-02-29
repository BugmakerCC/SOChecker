pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";

contract Counter is KeeperCompatibleInterface {
    
    uint public counter;

    
    uint public immutable interval;
    uint public lastTimeStamp;

    constructor(uint updateInterval) {
      interval = updateInterval;
      lastTimeStamp = block.timestamp;

      counter = 0;
    }

    function checkUpkeep(bytes calldata 
) {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
    }

    function performUpkeep(bytes calldata 
) external override {
        if ((block.timestamp - lastTimeStamp) > interval ) {
            lastTimeStamp = block.timestamp;
            counter = counter + 1;
        }
    }
}


