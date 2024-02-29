let result = web3.eth.abi.decodeLog([{
    type: 'string',
    name: 'tokenTicker',
    indexed: true
    }],
    data,
    topics[1]);

event BridgeAdded(
        uint256 indexed id,
        string tokenTicker,
        string tokenName,
        string imageUrl
    );

event BridgeAdded(
            string indexed indexedTokenTicker,
            string tokenTicker,
            string tokenName,
            string imageUrl
        );


