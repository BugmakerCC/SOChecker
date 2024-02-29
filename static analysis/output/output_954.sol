pragma solidity ^0.8.9;
interface TokenIdInterface {
  function associate() external returns (bytes32);
  function dissociate() external returns (bytes32);
}

