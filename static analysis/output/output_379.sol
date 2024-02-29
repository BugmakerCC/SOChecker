pragma solidity ^0.8.9;
contract Custodial {
    address owner;

    constructor(){
        require(owner == msg.sender);  
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(owner == msg.sender);  
        owner=newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

