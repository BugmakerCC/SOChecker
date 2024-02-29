pragma solidity ^0.8.9;
library MultipleValues {

    function returnValues() public pure returns (uint, bool, uint[3] memory) {
        uint[3] memory memoryArray;
        memoryArray[0]=1;
        memoryArray[1]=2;
        memoryArray[2]=3;
        return (23, true, memoryArray);
    }
}

