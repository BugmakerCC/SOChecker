pragma solidity ^0.4.25;
contract Inbox {

    address private inbox;

    address public contractAddress;

    constructor(address _inbox) public{
        inbox = _inbox;
        contractAddress = msg.sender;
    }

    function() public payable {
    }
}

