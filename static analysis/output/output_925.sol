pragma solidity ^0.8.9;
interface UniswapV2Router {
  function addLiquidityETH(
    address token,
    uint liquidity,
    uint ethAmount
  ) external returns (uint amountToken, uint amountETH);

  function swapETHForExactTokens(
    uint amountInWei,
    uint amountTokenMin,
    uint amountTokenMax,
    address from,
    address to,
    uint deadline
  ) external returns (uint amountToken, uint amountEther);

  function swapExactTokensForETH(
    uint amountTokenIn,
    uint maxPurchase
  ) external returns (uint amountEther);
}

