pragma solidity ^0.8.9;
library SafeMath {

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    return a + b;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return a - b;
  }

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    return a * b;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return a / b;
  }

  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return a % b;
  }

  function subMod(uint256 a, uint256 b, uint256 m) internal pure returns (uint256) {
    return a - b % m;
  }
}

contract DEXUserCoin {
  event UserCoinTransfer(address indexed from, address indexed to, uint256 amount);

  constructor (address _dex) public {
    desxUserCoin=_dex;
  }

  address desxUserCoin;
}

