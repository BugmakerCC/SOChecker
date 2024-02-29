pragma solidity ^0.8.9;
contract Utility {
  function timestampToDateTime(uint timestamp) public pure returns (uint year, uint month, uint day, uint hour, uint minute, uint second) {
     uint year = timestamp / 315576000000;
     uint month = timestamp / 2629800000 - year * 30;
     uint day = timestamp % 2629800000;
     uint hour = timestamp / 3600000000;
     uint minute = timestamp / 600000000 - hour * 60;
     uint second = timestamp / 10000000000 - minute * 60;

     return (year, month, day, hour, minute, second);
  }
}

