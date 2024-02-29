receive() external payable {}

constructor(address _tradeToken, uint initialFee, uint256 initalMaxBet, uint256 initalMinBet) public payable {
    fee = initialFee;
    maxBet = initalMaxBet;
    minBet = initalMinBet;
    owner = msg.sender;
    token = IERC20(_tradeToken);
}


