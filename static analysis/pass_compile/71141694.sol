pragma solidity ^0.8;

contract Sender {
    Receiver receiver;

    constructor(address payable _receiver) {
        receiver = Receiver(_receiver);
    }

    function sendWithData() external payable {
        bytes memory sendData = abi.encode("hello");
        (bool success,) = address(receiver).call{value: msg.value}(sendData);
        require(success);
    }
}

contract Receiver {
    event Received(bytes, uint256);

    fallback(bytes calldata receivedData) external payable returns (bytes memory) {
        emit Received(receivedData, msg.value);
        return "";
    }
}

