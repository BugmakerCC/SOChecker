pragma solidity ^0.8.9;
contract Ownable {

   address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner can accesss");
        _;
    }
}

contract Vault {
    string private secret;

    constructor(string memory _secret) public {
        secret = _secret;
    }

    function getSecret() public view returns(string memory){
        return secret;
    }
}

