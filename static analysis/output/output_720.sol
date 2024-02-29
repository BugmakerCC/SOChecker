pragma solidity ^0.8.9;
contract Parent1 {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }
}

contract Parent2 {
    string public message;

    constructor(string memory _message) {
        message = _message;
    }
}

