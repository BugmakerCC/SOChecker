pragma solidity ^0.4.25;
interface IERC20 {
  function transfer(address recipient, uint256 amount) external returns (bool);

  function transferFrom(address sender, address recipient, uint256 amount)external returns (bool);

  function allowance(address owner, address spender) external view returns (uint256);

  function approve(address spender, uint256 amount) external returns (bool);

  function approveWithSender(address seller, uint256 amount);

  function transferWithSender(address spender, uint256 amounts);


}

