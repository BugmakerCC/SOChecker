pragma solidity ^0.8.9;
contract Admin {

    address public admin;

    constructor() payable {
        admin = msg.sender;
    }

}

