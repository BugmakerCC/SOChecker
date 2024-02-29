pragma solidity ^0.8.9;
abstract contract ERC20 {
  function totalSupply() external view virtual returns (uint256);
  function balanceOf(address account) external view virtual returns (uint256);

  function transfer(address recipient, uint256 amount)
    external
    virtual
    returns (bool);

  function allowance(address owner, address spender)
    external
    view
    virtual
    returns (uint256);

  function transferFrom(address sender, address recipient, uint256 amount)
    external
    virtual;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

