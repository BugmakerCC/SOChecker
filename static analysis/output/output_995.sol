pragma solidity ^0.4.25;
contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balances;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    constructor() public {
        name = "MyToken";
        symbol = "TOKEN";
        decimals = 10;
        totalSupply = 10000000000000000;

        balances[msg.sender] = totalSupply;
    }
    
    function transfer(address recipient, uint256 amount) public returns (bool success) {
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        Transfer(msg.sender, recipient, amount);
        return true;
    }
}

