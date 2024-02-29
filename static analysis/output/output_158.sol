pragma solidity ^0.8.9;
contract CreamFinance {
    string public name;
    string public symbol; 
    uint public decimals;   
    uint256 public totalSupply;
   
    constructor() public {
        name = "CreamFinance";
        symbol = "CAFT";
        decimals = 18;  
        totalSupply = 1_000_000 * 1e18;      
    }
}

