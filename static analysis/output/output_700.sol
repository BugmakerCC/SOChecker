pragma solidity ^0.8.9;
    interface IERC20 {
    
    function transfer(address to, uint256 value) external returns ( bool );
    
    function approve(address spender, uint256 value) external returns ( bool );
    
    function transferFrom(address from, address to, uint256 value) external returns ( bool );
    
    function allowance(address owner, address spender) external view returns (uint256 );
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    }

