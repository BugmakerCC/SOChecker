function swap(address tokenIn, uint amountIn) public {
    require(
        msg.sender == owner1 || msg.sender == owner2,
        "Not authorized from owners"
    );
    require(
        token1.allowance(owner1, address(this)) >= amount1,
        "Token 1 allowance too low"
    );
    require(
        token2.allowance(owner2, address(this)) >= amount2,
        "Token 2 allowance too low"
    );
    require(
        tokenIn == address(token1) || tokenIn == address(token2),
        "Invalid token"
    );
    require(_amountIn > 0, "invalid amount");
    bool isToken1 = tokenIn == address(token1);
    (   
        Token tokenIn,
        Token tokenOut,
        uint reserve1,
        uint reserve2
    ) = isToken1
            ? (token1, token2, reserve1, reserve2)
            : (token2, token1, reserve2, reserve1);
    _safeTransferFrom(tokenIn, owner1, owner2, amount1);
    uint amountInAfterFee = (_amountIn * 997) / 1000;
     amountOut =
        (reserve2 * amountInAfterFee) /
        (reserve1 + amountInAfterFee);
    token2.transfer(msg.sender,amountOut)

}


