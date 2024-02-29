pragma solidity ^0.8.9;
contract ReverseArray {

    function reverseArray(uint[] calldata array) public pure returns(uint[] memory) {
        uint length = array.length;
        uint[] memory reversedArray = new uint[](length);
        uint j = 0;
        for(uint i = length; i >= 1; i--) {
            reversedArray[j] = array[i-1];
            j++;
        }
        return reversedArray;
    }

}

