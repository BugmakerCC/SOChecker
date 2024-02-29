pragma solidity ^0.4.25;
contract PaymentGateway {

  function () external payable {
    require(msg.value > 0.1 ether); 
  }


}

