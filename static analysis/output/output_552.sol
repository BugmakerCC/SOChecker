pragma solidity ^0.8.9;
contract MyContract {
    uint256 public myVariable;

    
    function setVariable(uint256 _myVariable) public {
        myVariable = _myVariable;
    }

    
    function getVariable() public view returns (uint256) {
        return myVariable;
    }
}

