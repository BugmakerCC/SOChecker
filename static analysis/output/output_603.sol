pragma solidity ^0.8.9;
contract Payments {
    mapping(address => Payment[]) public mainMap;

    struct Payment {
        uint256 amount;
        uint256 timestamp;
    }

    function pay() public payable {
        Payment[] storage payment = mainMap[msg.sender];
        payment.push(Payment({amount: msg.value, timestamp: block.timestamp}));
        mainMap[msg.sender] = payment;
    }
}

