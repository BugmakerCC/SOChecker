pragma solidity ^0.8.9;
interface AggregatorV3Interface {
 function latestAnswer(address aggregator) external view returns (uint256);
 }

