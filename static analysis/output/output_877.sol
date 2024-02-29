pragma solidity ^0.8.9;
interface IERC20 {
    function transfer(address to, uint amount) external returns (bool success, uint amount0);
}

interface IWETH9 {
    function deposit(uint amount) external payable;
}

