pragma solidity ^0.8.9;
contract MyContract {
    event DataRequested(string url);

    function requestData(string memory url) public {
        emit DataRequested(url);
    }

    function receiveData(bytes memory data) public {
        require(msg.sender == address(0x123));
    }
}

