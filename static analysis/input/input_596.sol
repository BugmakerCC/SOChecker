function betLottery() external {
    if (block.timestamp % 2 == 0) {
        win();
    }
}

struct Saving {
    uint256 balance;
    uint256 endBlock;
}

require(
    block.number > balances[msg.sender].endBlock,
    "You cannot withdraw yet"
);


