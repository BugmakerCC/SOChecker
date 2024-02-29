pragma solidity ^0.8.9;
contract Response {
    function respond(string memory _message) public {
        emit ResponseMessage(_message);
    }

    event ResponseMessage(string _message);
}

