pragma solidity ^0.8.9;
contract YourContract {
  receive() external payable {
    revert();
  }
}

