
 IERC20(WETH).approve(routerA, amount);

        IUniswapV2Router02(routerA).swapExactTokensForTokensSupportingFeeOnTransferTokens(
            amount, 
            0, 
            path2, 
            cttAddress, 
            block.timestamp + 1200
        );      



