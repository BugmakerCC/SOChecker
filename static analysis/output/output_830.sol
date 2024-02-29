pragma solidity ^0.8.9;
contract MyContract {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    function getContractOwner() public view returns (address) {
        return owner;
    }
}

