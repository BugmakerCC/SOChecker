pragma solidity ^0.8.9;
contract ArrayManipulator {
    uint[] public arrayOne;
    uint[] public arrayTwo;

    function setArrays(uint[] memory _arrayOne, uint[] memory _arrayTwo) public {
        require(_arrayOne.length == _arrayTwo.length, "Array lengths must be equal");
        arrayOne = _arrayOne;
        arrayTwo = _arrayTwo;
    }

    function manipulateArrays(uint _valueOne, uint _valueTwo) public {
        require(arrayOne.length == arrayTwo.length, "Array lengths must be equal");
        
        // Loop through each element in the arrays
        for (uint i = 0; i < arrayOne.length; i++) {
            arrayOne[i] = _valueOne;
            arrayTwo[i] = _valueTwo;
        }
    }
}

