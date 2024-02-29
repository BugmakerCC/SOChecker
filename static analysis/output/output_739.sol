pragma solidity ^0.8.9;
interface IERC20 {
  function transfer(address to, uint value) external returns (bool);
  function balanceOf(address who) external view returns (uint);
  function allowance(address owner, address spender) external view returns (uint);
  function transferFrom(address from, address to, uint value) external returns (bool);
  function approve(address spender, uint value) external returns (bool);
  function getApproved(address spender) external view returns (uint);
  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);
}

interface IWETH9 {
  function weth9() external returns (uint); 
  function weth9(uint) external payable returns (uint);
}

