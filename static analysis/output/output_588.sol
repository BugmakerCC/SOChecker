pragma solidity ^0.4.25;
contract ERC20 {
    function balanceOf(address owner) external view returns (uint balance);
    function transfer(address recipient, uint amount) external returns (bool success);
    function allowance(address owner, address spender) external view returns (uint remaining);
    function approve(address spender, uint amount) external returns (bool success);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool success);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

