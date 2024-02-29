pragma solidity ^0.8.9;
contract PuisEth {

    uint public size;

    uint[] arr;

    constructor() {
        size = 0;
    }

    function set(uint index, uint value) public {
        require(index < size, "Index out of bounds");
        require(value != 0, "Value should be non zero");
        arr[index] = value;
        size = index + 1;
    }

    function get(uint index) public view returns (uint) {
        require(index < size, "Index out of bounds");
        return arr[index]; 
    }
}

