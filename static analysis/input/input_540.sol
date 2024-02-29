function claimFreeToken() public payable {
    _transfer(address(this), msg.sender, 1000 * (10**decimals()));
}


