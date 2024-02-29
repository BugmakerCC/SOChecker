pragma solidity ^0.8.9;
interface MultiToken {
    function balanceOf(address account) external view returns (uint);
    function transferFrom(address from, address to, uint256 value) external;
}

