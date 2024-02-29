pragma solidity ^0.8.9;
interface IERC20 {
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transfer(address to, uint amount) external returns (bool);

    function transferFrom(address from, address to, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);
}

