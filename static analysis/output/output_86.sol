pragma solidity ^0.8.9;
interface IERC20 {
    function transferFrom(address sender, address recipient, uint32 amount) external returns (bool);
}

