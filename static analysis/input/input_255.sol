contract SelfWhitelist {

    mapping(address => bool) public addressWhitelist;

    function whitelist() public returns(string memory) {
        if (check()) {
            return "Already whitelisted!";
        }
        addressWhitelist[msg.sender] = true;
        return "Whitelisted!";
    }

    function check() public view returns (bool) {

        return addressWhitelist[msg.sender];
    }
}

 for(uint i = 0; i < addressWhitelist.length; i++) {
    if(addressWhitelist[i] != msg.sender) {
        addressWhitelist.push(msg.sender);
        return "Whitelisted!";
    }
}


