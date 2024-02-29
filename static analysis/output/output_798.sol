pragma solidity ^0.8.9;
    interface ERC20 {
        function transfer(address to, uint value) external returns (bool);
        function totalSupply() external view returns (uint);
        function balanceOf(address who) external view returns (uint);
        function allowance(address owner, address spender) external view returns (uint);
    }

