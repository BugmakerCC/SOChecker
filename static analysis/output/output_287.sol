pragma solidity ^0.8.9;
interface IERC20 {
   function transferFrom(address sender, address recipient, uint amount) external returns(bool);
}

