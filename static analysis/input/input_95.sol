function updateStructA(string memory _newValue) public {
    tests[msg.sender].a = _newValue;
}

function updateStructB(string memory _newValue) public {
    tests[msg.sender].b = _newValue;
}


