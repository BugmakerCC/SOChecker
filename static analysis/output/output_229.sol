pragma solidity ^0.8.9;
    interface IERC20 {
        function totalSupply() external view returns (uint);
        function balanceOf(address account) external view returns (uint256);
        function allowance(address owner, address spender) external view returns (uint256);
        function transferFrom(address src,address dst,uint256 value) external returns (bool);
    }

