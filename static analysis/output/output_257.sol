pragma solidity ^0.8.9;
interface IERC20 {
   function transfer(address _to, uint256 _value) external returns (bool);
   function balanceOf(address account) external view returns (uint);
}

