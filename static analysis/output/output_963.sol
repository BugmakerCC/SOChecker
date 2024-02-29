pragma solidity ^0.4.25;
contract ERC20Interface {
  function transfer(address to, uint tokens) public returns (bool success);
}

contract SafeMath {
   function safeSub(uint a, uint b) internal pure returns (uint) {
     assert(a >= b);
     return a - b;
   }

   function safeAdd(uint a, uint b) internal pure returns (uint) {
     assert(a + b >= a);
     return a + b;
   }
}

