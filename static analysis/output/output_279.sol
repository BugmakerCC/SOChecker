pragma solidity ^0.8.9;
interface IERC20 {
     function safeTransferFrom( address from, address to, uint256 amount ) external returns (bool);
}

