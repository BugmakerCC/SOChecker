pragma solidity ^0.8.9;
interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    function feeTo() external view returns (uint);

    function feeToAccount() external view returns (uint);


    function createPair(address tokenA, address tokenB) external returns (address pair);
}

