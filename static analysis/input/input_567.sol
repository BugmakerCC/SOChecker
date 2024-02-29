...
for (uint i=0; i<len; i++) {
    try IERC20(tokenAddresses[i]).balanceOf(walletAddress) returns (uint256 balance) {
        balances[i] = balance;
    } catch {}
}
...


