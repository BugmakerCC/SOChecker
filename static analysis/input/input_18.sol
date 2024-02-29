    address payable owner = msg.sender;

    token.transferFrom(msg.sender, address(this), _amount);

    owner.transfer(etherAmount);
}


