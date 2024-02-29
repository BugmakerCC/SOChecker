pragma solidity ^0.4.25;
contract MyContract {
  address private wallet = 0x0000000000000000000000000;

  function() external payable {
    uint256 _value = msg.value;
    
    require (
      msg.value >= 1 ether,
      "This contract accepts only 1 ether payments"
    );
  
    wallet.transfer(_value);
  }
}

