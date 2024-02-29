pragma solidity ^0.8.9;
contract OracleResponse {
    mapping(bytes32 => ResponseInfo) public oracleResponses;

    struct ResponseInfo {
        address requester;
        bool isOpen;
    }

    event RequestForResponse(bytes32 indexed id, bool indexed responseOpen);

    function sendResponse(bytes32 id) public returns (bool isResponseOpen) {
        ResponseInfo storage response = oracleResponses[id];
        response.isOpen = true;
        emit RequestForResponse(id, response.isOpen);
        return response.isOpen;
    }

    function setResponseOpen(bytes32 id, bool isOpen) public {
        oracleResponses[id].isOpen = isOpen;
    }
}

