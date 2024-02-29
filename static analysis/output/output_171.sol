pragma solidity ^0.8.9;
contract GreetingExample {

    function setGreetings(string calldata _message) external {
        message=_message;
    }

    string public message;
}

