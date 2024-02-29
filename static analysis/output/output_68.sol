pragma solidity ^0.8.9;
library SafeMathLibrary {
  function times(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    require(c / a == b, "SafeMathLib: multiplication overflow");
    return c;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMathLib: addition overflow");
    return c;
  }

}

