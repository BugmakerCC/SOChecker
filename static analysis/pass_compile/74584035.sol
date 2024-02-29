pragma solidity ^0.8;

contract MyContract {
    uint[2][2] public fixedArray;
    uint[][] public dynamicArray;

    constructor() {
        fixedArray[0][0] = 1;
        fixedArray[0][1] = 2;
        fixedArray[1][0] = 3;
        fixedArray[1][1] = 4;

        // workaround - cannot resize in-memory dynamic-size arrays
        // so we declare a "dynamic array with predefined length" in memory
        uint[] memory dynamicArrayNested1 = new uint[](2);
        dynamicArrayNested1[0] = 5;
        dynamicArrayNested1[1] = 6;
        dynamicArray.push(dynamicArrayNested1);
        uint[] memory dynamicArrayNested2 = new uint[](2);
        dynamicArrayNested2[0] = 7;
        dynamicArrayNested2[1] = 8;
        dynamicArray.push(dynamicArrayNested2);
    }
}

