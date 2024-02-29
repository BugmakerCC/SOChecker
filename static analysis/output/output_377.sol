pragma solidity ^0.8.9;
library MockV3AggregatorLib {
  function getRandom() internal view returns (uint256) {
    return uint256(uint(keccak256(abi.encodePacked(block.timestamp))) % 100);
  }
}

contract MockV3Aggregator {
  uint256[] public prices;
  uint256[] public amounts;

  constructor(uint256[] memory _prices, uint256[] memory _amounts) {
    prices = _prices;
    amounts = _amounts;
  }

  function getPrices() external view returns (uint256[] memory) {
    return prices;
  }

  function getAmounts() external view returns (uint256[] memory) {
    return amounts;
  }
}

