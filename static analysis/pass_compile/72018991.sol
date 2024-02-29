pragma solidity ^0.8;

contract Structing {
    // type definition
    struct DataOne {
        uint indexOne;
        address toOne;
    }

    // type definition
    struct DataTwo {
        uint indexTwo;
        address toTwo;
    }

    // typed properties
    DataOne dataOne;
    DataTwo dataTwo;

    // TODO implement setters of `dataOne` and `dataTwo` properties

    function getDataOne() public view returns (DataOne memory) { // returns type
        return dataOne; // property name
    }

    function getDataTwo() public view returns (DataTwo memory) { // returns type
        return dataTwo; // property name
    }
}

