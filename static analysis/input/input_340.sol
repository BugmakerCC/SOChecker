sendMoney() public payable  {
    address payable receiver = 
    payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);

    (bool sent, bytes memory data) = receiver.call{ value:  1 ether }("");
    require(sent, "Failed to send Ether");
}


