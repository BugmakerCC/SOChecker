pragma solidity ^0.8.9;
interface IERC20 {
  function transfer(address to, uint256 value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool);
  function approve(address spender, uint256 value) external returns (bool);
  function allowance(address tokenOwner, address spender) external view returns (uint256);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed tokenOwner, address indexed spender, uint256 value);
}

interface IERC223 {
  function transfer(address to, uint256 value) external returns (bool);
  function approve(address spender, uint256 value) external returns (bool);
  function getApproved(address tokenOwner, address spender) external view returns (uint256);
}

contract Ownable {
  address private owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  function transferOwnership(address newOwner) public onlyOwner {
    owner = newOwner;
  }
}

