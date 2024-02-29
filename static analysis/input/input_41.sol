function go(uint[] calldata amounts, uint16[] calldata destChainIds, bytes[] calldata destinations) public payable {
    uint length = 2;
    for (uint i; i < length; i++) {
        SendToken(amounts[i], destChainIds[i], destinations[i]);
    }
}


