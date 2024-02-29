pragma solidity ^0.8.9;
contract BlackList {
  mapping(address => bool) public _isBlackList;
  
  address private _owner;
  address owner;
  
  modifier onlyOwner() {
    require(msg.sender == owner, "You are not the owner");
    _;
  }

  
  constructor(address owner) {
    _owner = owner;
  }

  
  
  function addBlackList(address toAdd) public onlyOwner {
    _isBlackList[toAdd] = true;
  }

  
  
  function removeBlackList(address toRemove) public onlyOwner {
    require(_isBlackList[toRemove], "Token is not black listed");
    _isBlackList[toRemove] = false;
  }

   
  
   function isBlackListed(address toCheck) public view returns (bool) {
     return _isBlackList[toCheck];
     }
}

