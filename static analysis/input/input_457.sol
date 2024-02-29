modifier compPurch() {
}

modifier realBuyerOrTimeBought() {
    require(msg.sender == buyer || block.timestamp >= time + 5);
}

function foo() public compPurch realBuyerOrTimeBought {
}


