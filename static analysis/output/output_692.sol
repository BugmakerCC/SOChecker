pragma solidity ^0.4.25;
contract Token {
  string public name = "Token";
  string public symbol = "TOK";
  uint public totalSupply = 1*10**(18) * 10**(12);
  uint public decimals = 18;
  address public owner = 0x063214833299078683915273043052825586669;
}

