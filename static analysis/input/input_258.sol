function changeMap() external {
  require(msg.sender == _contractBAddress, 'address not match');
}

modifier onlyContractB {
        require(
            msg.sender == _contractBAddress,
            "Only contractB can call this function."
        );
        _;
    }

function changeMap() onlyContractB {
}


