// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Test {
    mapping(uint => string[]) mString;
    
    // Adding elements inside mapping
    function fillMapping(uint key, string[] memory values) public {
        mString[key] = values;
    }

    // Getter method for retrieve values from mapping, querying for a specific key 
    function getValueFromMapping(uint key) public view returns(string[] memory) {
        return mString[key];
    }
    
    // Using mapping values in other function
    function useMappingInOtherFunction(uint key) public {
        string[] memory stringValues = getValueFromMapping(key);
        // your logic
        // ...
        //
    }
    
}

