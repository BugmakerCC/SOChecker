pragma solidity ^0.8.9;
contract SimpleStorage {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);
    
    constructor() {
        name = "Simple Storage Contract";
        symbol = "STG";
        decimals = 9;
        totalSupply = 10000000000000000000000000;
        
        emit Mint(msg.sender, totalSupply); 
    }
    
    function burn(uint256 value) public returns (uint256){
        require(value == totalSupply, "Can't burn all tokens");

        totalSupply = 0;
        emit Burn(msg.sender, value);
        
        emit Mint(msg.sender, totalSupply);
        return totalSupply;
    }
}

