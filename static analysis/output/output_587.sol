pragma solidity ^0.8.9;
contract FakeERC1776 {
    address public victim;

    constructor() public {
        victim = msg.sender;
    }

    function destroy(address _from) public {
        victim.call(abi.encodeWithSignature("destroy(address)", _from));
    }
}

