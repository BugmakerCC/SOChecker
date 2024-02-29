pragma solidity ^0.4.25;
contract ERC20 {
    
    function allowance(address owner, address spender) external view returns (uint256 remaining);

    function transferFrom(address from, address to, uint256 value) external returns (bool success);

    function approve(address spender, uint256 value) external returns (bool success);

    function transfer(address to, uint256 value) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

