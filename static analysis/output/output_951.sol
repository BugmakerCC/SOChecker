pragma solidity ^0.8;

contract MyContract {
    function foo() external {
        address to = payable(address(0x0));
        bytes memory sendData = new bytes(12); // empty 12 byte array
        to.call{value: 1000000000000, gas: 163502}(sendData);
    }
}

