pragma solidity >=0.7.0 <0.9.0;

contract MappingInFunction {
    mapping (uint => string) public Names;
    uint public counter;
   
    function addToMappingInsideFunction(string memory name) public returns (string memory localName)  {
        mapping (uint => string) storage localNames = Names;
        counter+=1;
        localNames[counter] = name;
        return localNames[counter];

}

}


