pragma solidity ^0.4.25;
contract ERC20Token {

    string public standard = 'Token 0.1';

    string public name;
    string public symbol;
    uint8 public decimals; 
    uint256 public totalSupply;   

    function name () public view returns (string) {
        return name;
    }
    
    
     
     
    function symbol () public view returns (string) {
        return symbol; 
    }

    
     
     
    function decimals () public view returns (uint8) {
        return decimals; 
    }

    
     
     
    function totalSupply () public view returns (uint256) {
        return totalSupply; 
    }

}

contract ERC20Receiver {

    address public owner;
    uint256 public amount;

}

