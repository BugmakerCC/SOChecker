pragma solidity ^0.8.9;
contract minter {

  mapping(address => bool) public whiteList;

  
  function whiteLister( address _user) external {
    whiteList[_user] = true;
  
  }

}

