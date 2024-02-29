pragma solidity ^0.8.9;
interface ILiquidityPoolAddress {
    function getPoolAddress() external view returns (address);
}

interface ILiquidityPoolOwner {
    function getPoolAddress() external view returns (address);
    function getOwner() external view returns (address);
}

