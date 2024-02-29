function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

[...]
data = router.swapExactTokensForTokens(
        tokens[1].balanceOf(account),
        1,
        path,
        attacker,
        chain.time(),
        {"from": account},
    )

>>> int(web3.eth.getTransactionReceipt(data.txid)["logs"][2]["data"], 16)
631376138468681379

>>> data.events
{'Approval': [OrderedDict([('owner', '0x33A4622B82D4c04a53e170c638B944ce27cffce3'), ('spender', '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'), ('value', 4500000000000000000)])], 'Transfer': [OrderedDict([('from', '0x33A4622B82D4c04a53e170c638B944ce27cffce3'), ('to', '0xA68d9dd94574d286A75D39b1516b348620FfDCA0'), ('value', 500000000000000000)]), OrderedDict([('from', '0xA68d9dd94574d286A75D39b1516b348620FfDCA0'), ('to', '0x33A4622B82D4c04a53e170c638B944ce27cffce3'), ('value', 631376138468681379)])], 'Sync': [OrderedDict([('reserve0', 14368623861531318621), ('reserve1', 11844678011344678012)])], 'Swap': [OrderedDict([('sender', '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'), ('amount0In', 0), ('amount1In', 500000000000000000), ('amount0Out', 631376138468681379), ('amount1Out', 0), ('to', '0x33A4622B82D4c04a53e170c638B944ce27cffce3')])]}


