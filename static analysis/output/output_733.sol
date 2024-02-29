pragma solidity ^0.8.9;
contract TinybarsDemo {
    function checkBalance()
        public view
        returns (uint256 senderBalance)
    {
        senderBalance = msg.sender.balance;
    }
}

