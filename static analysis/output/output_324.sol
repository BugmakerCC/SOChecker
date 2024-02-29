pragma solidity ^0.8.9;
contract SendEther {
  function send(address payable _to) external payable {
    _to.transfer(msg.value); 
  }

  receive() external payable {}
}

