pragma solidity ^0.4.25;
contract ERC20 {
  function balanceOf(address account) external view returns (uint256);
  function transfer(address to, uint256 value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
}

