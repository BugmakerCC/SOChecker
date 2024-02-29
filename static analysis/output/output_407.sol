pragma solidity ^0.4.25;
interface Token {
    
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);
    function transfer(address to, uint value) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function transferFrom(address from, address to, uint value) external returns (bool);

    function approve(address spender, uint value) external returns (bool);
    function approveAndCall(address spender, uint value, bytes data) public returns (bool Success);
}

