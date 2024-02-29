pragma solidity ^0.8.9;
contract TestLoop {
    uint32[4] testArray;

    function setArrayWithLoop(uint32[4] memory array) public {
        for(uint256 i = 0; i < array.length; i++)
            testArray[i] = array[i];
    }

    function setArrayWithoutLoop(uint32[4] memory array) public {
        testArray = array;
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

contract NoLoop {
    uint32[4] testArray;

    constructor(uint32[4] memory array) {
        testArray = array;
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

contract Loop {
    uint32[4] testArray;

    constructor (uint32[4] memory array) {
        for(uint256 i = 0; i < array.length; i++)
            testArray[i] = array[i];
    }

    function show() public view returns (uint32[4] memory) {
        return testArray;
    }
}

