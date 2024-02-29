function invest(address referrer, uint8 plan) public payable {
    uint256 fee = msg.value.mul(PROJECT_FEE).div(PERCENTS_DIVIDER);
    commissionWallet.transfer(fee);
    emit FeePayed(msg.sender, fee);


