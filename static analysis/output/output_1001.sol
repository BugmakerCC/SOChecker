pragma solidity ^0.8.9;
interface ERC20Interface {
    
    
    function totalSupply() external view returns(uint);
    
    function balanceOf(address account) external view returns(uint);
    
    function transfer(address recipient, uint amount) external returns(bool);
    
    function allowance(address owner, address spender) external view returns(uint);
    
    function transferFrom(address sender, address recipient, uint amount) external returns(bool);
    
    function approve(address spender, uint amount) external returns(bool);
    
    
    event Transfer(address indexed sender, address indexed recipient, uint amount);
    
    
    event Approval(address indexed owner, address indexed spender, uint amount);
}

