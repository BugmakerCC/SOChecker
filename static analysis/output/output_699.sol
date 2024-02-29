pragma solidity ^0.4.25;
contract MathLib {
  function divisionRoundUp(uint256 x, uint256 y) pure returns (uint256 z) {
    z = (x + (y / 2) / y);
  }
}

