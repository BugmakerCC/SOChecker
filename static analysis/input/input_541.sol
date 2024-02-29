function reverseArray(uint[] calldata _array) public pure returns(uint[] memory) {
    uint length = _array.length;
    uint[] memory reversedArray = new uint[](length);
    uint j = 0;
    for(uint i = length; i >= 1; i--) {
        reversedArray[j] = _array[i-1];
        j++;
    }
    return reversedArray;
}


