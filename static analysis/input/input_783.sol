function burn(uint256 _value) public {
    
    emit Transfer(msg.sender, address(0), _value)
}


