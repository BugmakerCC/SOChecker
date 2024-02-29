pragma solidity ^0.4.25;
contract Inbox {
    address public owner;
    uint public count;

    event LogNewInbox(address indexed sender, uint indexed logCount);

    constructor() public {
        owner = msg.sender;
        count = 0;
    }

    function() external payable {
        count++;
        emit LogNewInbox(msg.sender, count);
    }
}

