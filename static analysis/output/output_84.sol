pragma solidity ^0.4.25;
contract IUniswapV3Factory {
    function getPool(
        address tokenA,
        address tokenB,
        uint24 fee
    )
    external
    returns (address poolAddress);
}

