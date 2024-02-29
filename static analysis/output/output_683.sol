pragma solidity ^0.8.9;
contract Test {
    address public owner;
    uint public firstVar = 10;
    uint private secondVar = 50;

    constructor() public {
        owner = msg.sender;
    }

    function returnOwner() public view returns (address){
        return owner;
    }
    
    function getSecondVar() public view returns (uint){
        require(msg.sender == owner, "Only the owner can see the second variable");
        return secondVar;
    }
}

