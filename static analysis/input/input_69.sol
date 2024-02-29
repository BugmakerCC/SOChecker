  function swapExactETHForTokens(uint amountOutMin, address token) external payable { 
    address[] memory path = new address[](2);
    path[0] = uniswap.WETH();
    path[1] = token;
    uniswap.swapExactETHForTokens{value: msg.value}(
      amountOutMin, 
      path,
      msg.sender, 
      now
    );
  }


