mapping(address => Payment[]) public mainMap;

function pay() public payable {
    Payment[] storage payment = mainMap[msg.sender];
    payment.push(Payment({amount: msg.value, timestamp: block.timestamp}));
    mainMap[msg.sender] = payment;
}


