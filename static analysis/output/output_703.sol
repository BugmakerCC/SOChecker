pragma solidity ^0.8.9;
library SafeMath {
  function add(uint a, uint b) internal pure returns (uint) {
    uint c = a + b;
    require(c >= a, "SafeMath: addition overflow");
    return c;
  }

  function subtract(uint a, uint b) internal pure returns (uint) {
    uint c = a - b;
    require(c >= a, "SafeMath: subtraction underflow");
    return c;
  }

  function multiply(uint a, uint b) internal pure returns (uint) {
    uint c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");
    return c;
  }

  function divide(uint a, uint b) internal pure returns (uint) {
    require(b > 0, "SafeMath: division by zero");
    return a / b;
  }
}

