pragma solidity ^0.8.9;
contract MyMap {
    mapping(bytes32 => uint) myMap;
    
    
    
    
    
    
  function setKey (bytes32 key) public {
    myMap[key] = 123;
  }
}

