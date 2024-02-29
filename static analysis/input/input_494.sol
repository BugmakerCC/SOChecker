function subscribe(uint planId) external payable {
    require(msg.value == 1 ether, "You need to send 1 ETH");
}

await window.ethereum.request(
    method: 'eth_sendTransaction',
    [
        from: userAddress,
        to: yourContract,
        data: <invoking the subscribe() function>,
        value: <1 ETH in wei, in hex>
    ]
);


