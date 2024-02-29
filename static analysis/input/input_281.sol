transferFrom(msg.sender, address(this), tokenAmount);
this.approve(uniswapV2Router.address, tokenAmount);

function swapTokensForEth(uint tokenAmount) public {
    require(tokenAmount > 0, "Need to send some tokens");
    require(tradingOpen, "Trading is not open yet");


    address[] memory path = new address[](2);
    path[0] = address(this);
    path[1] = uniswapV2Router.WETH();

    transferFrom(msg.sender, address(this), tokenAmount);
    this.approve(uniswapV2Router.address, tokenAmount);

    uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
        tokenAmount,
        0, 
        path,
        msg.sender, 
        block.timestamp + 300 
    );
}


