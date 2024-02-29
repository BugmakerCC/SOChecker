pragma solidity ^0.8.9;
interface IERC20 {
    
    function mint(address account) external;
}

interface IMinter {
    
    function mint(address account) external payable;
}

