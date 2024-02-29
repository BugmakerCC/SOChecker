pragma solidity ^0.8.9;
interface uniswap {
  
  function swapExactETHForTokens(uint amountOutMin, address token) external payable returns (uint amountOut);
  
  function WETH() external view returns (address);
}

