_totalSupply = 1000000000000 * 1e18;

_totalSupply = 1000000000000 * (10 ** decimals);

_totalSupply = 1000000000000 ether;

_totalSupply = 1000000000000 * 1e18;

address[3] memory devs = [address(0x123), address(0x456), address(0x789)];
address dapp = address(0xabc);
address exchange = address(0xdef);

uint256 totalSupplyRemaining = _totalSupply;

uint256 devBalance = _totalSupply / 100;
for (uint i = 0; i < 3; i++) {
    balances[devs[i]] = devBalance;
    emit Transfer(address(0x0), devs[i], devBalance);
    totalSupplyRemaining -= devBalance;
}

uint256 dappBalance = _totalSupply / 2;
balances[dapp] = dappBalance;
emit Transfer(address(0x0), dapp, dappBalance);
totalSupplyRemaining -= dappBalance;

balances[exchange] = totalSupplyRemaining;
emit Transfer(address(0x0), exchange, totalSupplyRemaining);


