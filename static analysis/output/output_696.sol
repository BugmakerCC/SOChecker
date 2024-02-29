pragma solidity ^0.8.9;
interface AggregatorV3Interface {
    function decimals() external view returns (uint8);
    function price(uint256) external view returns (uint256);
}

