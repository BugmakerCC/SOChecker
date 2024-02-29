pragma solidity ^0.8.9;
    interface AggregatorV3Interface {
      
      function latestRoundData() external view returns (
        uint80 roundID, 
        int price,
        uint startedAt,
        uint timeStamp,
        uint80 answeredInRound
      );
    }

