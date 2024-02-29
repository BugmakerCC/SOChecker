pragma solidity ^0.8.9;
interface IERC20 {
    
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);     

    function transfer(address recipient, uint256 amount) external returns (bool);    

    function allowance(address owner, address spender) external view returns (uint256);    

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);    
}

