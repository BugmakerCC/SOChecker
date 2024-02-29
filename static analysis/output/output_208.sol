pragma solidity ^0.8.9;
contract Escrow {

  receive() external payable {
    payable(buyer).transfer(msg.value);
  }

  address private buyer;

}

