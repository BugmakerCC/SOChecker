pragma solidity ^0.8.9;
contract PaymentGateway { 
    receive() external payable {}
    fallback() external payable {}
}

contract Payment {
    function sendPayment(address payable recipient, uint amount) external returns (uint) {
        require(msg.sender == tx.origin, "Reverting, Method can only be called directly by user.");  
        recipient.transfer(amount); 
        return amount;  
    }
}

