pragma solidity ^0.8.9;
interface EIP712Recover {
  function recover(bytes32 _hash, bytes calldata _sig) external returns(address);
  
}

