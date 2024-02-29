pragma solidity ^0.8.9;
library SafeMath {

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a, "SafeMath: subtraction underflow");
    return a - b;
  }

  function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    require(a == 0 || c / a == b, "SafeMath: multiplication overflow");
    return c;
  }
}

