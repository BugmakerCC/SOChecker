pragma solidity ^0.8.9;
contract Auth {
    address owner;
    mapping(address => bool) public AuthAccounts;

    constructor(address _addr_1, address _addr_2) public {
        owner = msg.sender;
        AuthAccounts[msg.sender] = true;
        AuthAccounts[_addr_1] = true;
        AuthAccounts[_addr_2] = true;
    }

    modifier onlyAuth() {
        require(AuthAccounts[msg.sender] == true, "Not Authorized");
        _;
    }

    function addAuthAccount(address _addr) public onlyAuth {
        AuthAccounts[_addr] = true;
    }

    function removeAuthAccount(address _addr) public onlyAuth {
        AuthAccounts[_addr] = false;
    }

    function checkAuth(address _addr) public view returns (bool) {
        return AuthAccounts[_addr];
    }
}

