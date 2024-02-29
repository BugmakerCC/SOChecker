function buy() external payable {
    uint256 amount = calculateAmount(msg.value);

    transfer(msg.sender, amount);
}


