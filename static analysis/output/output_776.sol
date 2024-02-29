pragma solidity ^0.8.9;
interface I {
  
  function getCurrentBalance() external view returns (uint);
  
  function transferOwnership(address newOwner) external;
}

