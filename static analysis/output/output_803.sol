pragma solidity ^0.8.9;
interface ERC20 {
  function balanceOf(address token) external view returns (uint256);
  function transfer(address to, uint256 tokens) external returns (bool);
}

