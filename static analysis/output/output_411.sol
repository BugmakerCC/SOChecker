pragma solidity ^0.8.9;
interface AggregatorV3Interface {

    function latestRoundData() external view returns (
        uint256
      ,uint256
      ,uint256
      ,uint256
      ,uint256
      ,uint256
      ,uint256
      ,uint256
      ,uint256
        );
}

