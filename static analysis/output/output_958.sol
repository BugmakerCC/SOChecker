pragma solidity ^0.8.9;
 abstract contract UniswapV2ERC20 {

    function _swap(address tokenA, address tokenB, uint amountOutMin, address to, uint deadline) internal virtual returns (uint amountIn);
}

