pragma solidity ^0.8.9;
contract Withdraw {
    function withdraw(uint _amount) external payable {
    payable(msg.sender).transfer(_amount);    
    }
}

