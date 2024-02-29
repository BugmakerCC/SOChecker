pragma solidity ^0.4.25;
contract MyContract {

    mapping(address => bool) public mappingName;

    function mappingName(address _myVar) public returns (bool) {
        return mappingName[_myVar];
    
    }

    function setMapping() public {
        mappingName[msg.sender] = true;
    }
 
}

