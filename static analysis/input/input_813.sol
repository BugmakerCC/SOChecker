constructor() {
    owner = msg.sender;
}

function transferOwnership(address newOwner) external onlyOwner {
    owner = newOwner;
}


