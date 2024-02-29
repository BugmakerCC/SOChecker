pragma solidity ^0.8.9;
interface IERC20 {
function transfer(address recipient, uint256 amount) external returns (bool);

function allowance(address owner, address spender) external view returns (uint256);

function transferFrom(address from, address to, uint256 value) external returns (bool);

function approve(address spender, uint256 amount) external returns (bool);

event Transfer(address indexed from, address indexed to, uint256 value);
}

