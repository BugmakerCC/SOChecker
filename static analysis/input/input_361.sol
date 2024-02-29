IdToAddress[Id] = address(0x123);

function transfer(address _recipient, uint256 _id) public {
    require(IdToAddress[_id] == msg.sender, "You're not the current token owner");
    IdToAddress[_id] = _recipient;
}


