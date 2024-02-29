pragma solidity ^0.8.9;
interface ResponseAggregator {
    function price(address asset) external view returns (uint256 priceUSD);
}

