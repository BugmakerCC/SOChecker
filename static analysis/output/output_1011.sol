pragma solidity ^0.4.25;
contract IFactory {

  function hasRole(
    bytes32 role,
    address account
  ) public view returns (bool);

  function grantsRole(bytes32 role, address account) public;
}

