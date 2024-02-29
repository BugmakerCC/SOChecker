pragma solidity ^0.8.7;

contract MAth{

uint public publicM;
uint public remPublic;

  constructor()  {
    publicM = 10;
  }
  function setRemPublic() public  returns(uint)  {
   remPublic = publicM;
   return remPublic;
  }
}


