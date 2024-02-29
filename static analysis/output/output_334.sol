pragma solidity ^0.8.9;
interface IERC20 {
    
    
    function name() external view returns (string memory);

    
    function symbol() external view returns (string memory);

    
    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint);

    
    function balanceOf(address account) external view returns (uint);

    
    function transfer(address recipient, uint amount) external returns (bool);

    
    function allowance(address owner, address spender) external view returns (uint);

    
    function approve(address spender, uint amount) external returns (bool);

    
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    
    event Transfer(address indexed from, address indexed to, uint tokens);

    
    event Approval(address indexed owner, address indexed spender, uint tokens);
}

interface IETH {
    
    function balanceOf(address account) external view returns (uint);

    
    function transfer(address recipient, uint amount) external returns (bool);
}

