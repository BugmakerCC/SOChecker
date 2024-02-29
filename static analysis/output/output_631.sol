pragma solidity ^0.4.25;
contract NumCon {
  bytes1 public hexNum = 0x2;
  bytes1 public hexStr = hex"02";
  bytes1 public numDecimal = 2;

  function add (uint8 a, uint8 b) internal returns (uint8) {
    return a + b;
  }

  function sub (uint8 a, uint8 b) internal returns (uint8) {
    return a - b;
  }

  function mul (uint8 a, uint8 b) internal returns (uint8) {
    return a * b;
  }

  function div (uint8 a, uint8 b) internal returns (uint8) {
    return a / b;
  }

}

