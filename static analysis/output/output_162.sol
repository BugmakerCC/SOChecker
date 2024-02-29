pragma solidity ^0.8.9;
contract ERC20Interactable {

    constructor (uint256 _amount, string memory _symbol, string memory _name) public {
     
     amount = _amount * 1e18;
    
     amount = _amount * (10 ** 18);
    }

    receive() external payable {
     
     amount = _amount * 1e18;
    
     amount = _amount * (10 ** 18);
    }

    uint public constant decimals = 18;

    string private symbol;
    string private name;
    uint256 private _amount;
    uint256 private amount;
}

