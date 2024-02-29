pragma solidity ^0.8.9;
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

