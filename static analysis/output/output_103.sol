pragma solidity ^0.8.9;
library PayWithEth {

  function sendEther (address receiver, uint amount) internal {
    payable(receiver).transfer(amount);
  }

}

