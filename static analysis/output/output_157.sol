pragma solidity ^0.8.9;
library SafeMath {

  function add(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = x + y;
    require(z >= x, "SafeMath: addition overflow");
  }

  function sub(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require(x >= y, "SafeMath: subtraction underflow");
    z = x - y;
  }

  function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = x * y;
    require(x == 0 || z / x == y, "SafeMath: multiplication overflow");
  }

  function div(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require(y > 0, "SafeMath: division by zero");
    z = x / y;
  }

  function mod(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = x % y;
    require(y > 0, "SafeMath: modulo by zero");
  }
}

