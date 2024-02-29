pragma solidity ^0.8.9;
interface ERC20 {
  function transfer(address to, uint value) external returns (bool);
  function transferFrom(address from, address to, uint value) external returns (bool);
  function approve(address spender, uint value) external returns (bool);
  function allowance(address owner, address spender) external view returns (uint);
}

