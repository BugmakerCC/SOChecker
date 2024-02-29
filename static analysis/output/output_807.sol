pragma solidity ^0.8.9;
contract Inbox {

    string public message;

    constructor(string memory initialMessage) public {
        message = initialMessage;
    }

    function sendMessage(string memory message) public {
        message = message;
    }
}

