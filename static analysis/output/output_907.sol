pragma solidity ^0.8.9;
interface IPancakeSwapRouter {
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amount0,
        uint256 amount1,
        address to,
        uint256 deadline
    ) external returns (uint256 amount);
}

interface IPancakeRouter {
    function swapTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amount0,
        uint256 amount1,
        uint256 path0,
        address from
    ) external returns (uint256 amount);
}

