pragma solidity ^0.8.9;
contract YourContractName {
  address private owner;

  constructor() public {
    owner = msg.sender;
  }

  function getContractOwner() public view returns (address) {
    return owner;
  }
}

