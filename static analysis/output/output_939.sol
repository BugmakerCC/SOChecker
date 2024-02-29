pragma solidity ^0.7.6;
contract Requester {

    event TransactionBytes(bytes transactionBytes);
    event RequestPaid(address payable sender, uint256 amount);

    function payRequest(address payable _recipient, uint256 _amount)payable public {
        
        (bool success, bytes memory transactionBytes) = _recipient.call{value:_amount}('');
        
        emit TransactionBytes(transactionBytes);
        
        emit RequestPaid(msg.sender, _amount);
    }
}

