pragma solidity ^0.8.9;
contract FillArray {

    string[] public myArray;

    function fillArrayMemory(string memory _word) public {
        myArray.push(_word);
    }

    function fillArray() public {
        string[] memory _array = new string[](2);
        _array[0] = "test";
        _array[1] = "test1";
    }
}

