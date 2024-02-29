pragma solidity ^0.8.9;
interface IERC20 {
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function decimals() external view returns (uint);
}

