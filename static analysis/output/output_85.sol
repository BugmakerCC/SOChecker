pragma solidity ^0.4.25;
interface IUser {
  function getName() external view returns (string memory);
}

contract Example {
  modifier callerIsUser() {
    require(tx.origin == msg.sender, "The caller is another contract");
    _;
  }

  constructor() {}

  function example() callerIsUser {
    IUser(0).getName();
  }
}

