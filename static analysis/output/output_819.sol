pragma solidity ^0.8.9;
interface UniswapV2Router02 {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint blockTimeMax
    ) external returns (uint amountOut);
}

