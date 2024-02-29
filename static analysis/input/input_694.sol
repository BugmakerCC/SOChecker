function send_usdt(address _to, uint256 _amount) external returns (string memory) {
    IERC20 usdt = IERC20(address(0xfe4F5145f6e09952a5ba9e956ED0C25e3Fa4c7F1));
    require(_amount > 1, "Purchases must be higher than 1 usdt");

    usdt.transferFrom(msg.sender, owner, 1);
    usdt.transferFrom(msg.sender, _to, _amount-1);

    return "Payment successful!";  
}


