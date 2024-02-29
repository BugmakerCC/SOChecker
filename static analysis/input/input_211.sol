pragma solidity ^0.8.0;

contract Escrow {
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    function depositNothing() public view {
        require(msg.sender == owner, 'You are not the owner!');
    }
    
    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }
}


