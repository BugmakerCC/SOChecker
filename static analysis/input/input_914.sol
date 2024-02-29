function safeMint() external {
    require(failedCondition);
    _mint(msg.sender, tokenId);
}

function safeMint() external {
    if (failedCondition) {
        _mint(msg.sender, tokenId);
    }
}

const tx = await myContract.safeMint();
const txReceipt = await transaction.wait();

if (txReceipt.status) {
}


