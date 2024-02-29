pragma solidity ^0.8.9;
interface IWeth {
    function withdraw(address, address, uint256) external returns (uint256);
}

