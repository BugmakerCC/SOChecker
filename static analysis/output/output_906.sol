pragma solidity ^0.4.25;
contract MyERC20Token {
    
    address public owner;
    
    
    
    constructor() payable {

        owner = msg.sender;

        }

    function () external payable {

    }
}

