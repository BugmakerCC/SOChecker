pragma solidity ^0.8;

contract Test {
    mapping(uint => string[]) mString;
    
    function fillMapping(uint key, string[] memory values) public {
        mString[key] = values;
    }

    function getValueFromMapping(uint key) public view returns(string[] memory) {
        return mString[key];
    }
    
    function useMappingInOtherFunction(uint key) public {
        string[] memory stringValues = getValueFromMapping(key);
    }
    
}


