pragma solidity ^0.4.25;
library IERC20 {
    function allowance(address, address) external view returns (uint256);

    function approve(address, uint256) external returns (bool);

    function balanceOf(address) external view returns (uint256);

    function transfer(address, uint256) external returns (bool);

    function transferFrom(address, uint256, address) external returns (bool);
}

