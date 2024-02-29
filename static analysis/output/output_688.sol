pragma solidity ^0.8.9;
contract StringStorage {

  function getStrings(uint startIndex, uint endIndex) view public returns (string[] memory) 
  {
    require(startIndex > 0, "Invalid start index");
    require(endIndex <= 0xFFFFFFFF, "End index exceeds limit");
    
    assembly {
      mstore(calldataload(0), 0)
      mstore(calldataload(1), calldataload(2))
      mstore(calldataload(3), calldataload(4))
      mstore(calldataload(5), calldataload(6))
      mstore(calldataload(7), 0)
      mstore(calldataload(8), 0)
      mstore(calldataload(9), 0)
    }
  }
}

