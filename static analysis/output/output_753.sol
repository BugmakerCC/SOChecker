pragma solidity ^0.8.9;
contract BooleanMap {

    
    function getAllBools() public view returns (bool[] memory) {
        bool[] memory result = new bool[](keys.length);
        for (uint i = 0; i < keys.length; i++) {
            result[i] = inserted[keys[i]];
        }
        return result;
    }

    mapping(address => bool) public inserted;
    address[] public keys;
}

