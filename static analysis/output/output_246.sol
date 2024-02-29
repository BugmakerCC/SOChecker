pragma solidity ^0.5.16;
 contract Address {
    function payment(address payable recipient) external payable {
      uint256 amount = msg.value;
      recipient.transfer(amount);
    }
  
   function () payable external{
    }
  }

