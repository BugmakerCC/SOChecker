pragma solidity ^0.8.9;
contract DummyContract {
    event LogSent(bytes32 data);

    function sendData(address otherContractAddress, bytes32 data) public {
        require(otherContractAddress != address(0), "Invalid address");
        (bool success,) = otherContractAddress.call(abi.encodePacked(data));
        require(success, "Call failed");
        emit LogSent(data);
    }
}

