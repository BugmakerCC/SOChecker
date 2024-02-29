pragma solidity ^0.8.9;
contract Token {
  string public name;
  string public symbol;
  uint public decimals;
  uint public totalSupply;

  constructor() public {
    name = "Safety Token";
    symbol = "SAFETY";
    decimals = 18;
    totalSupply = 1000000000000000000000000000000;
    
  }
}

