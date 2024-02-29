pragma solidity ^0.4.25;
interface SimpleStorage {
  function getData(uint16 id) external returns(string);
  function putData( uint16 id, string data) external returns(string);
  function getName() external returns (string);
  function version() external returns (string);
}

