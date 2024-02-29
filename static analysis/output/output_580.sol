pragma solidity ^0.8.9;
interface ERC20 {
  function totalSupply() external view returns (uint);
  function balanceOf(address) external view returns (uint);
  function transfer(address, uint) external returns (bool);
}

