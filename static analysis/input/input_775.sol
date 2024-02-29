pragma solidity ^0.8;

contract Structing {
    struct DataOne {
        uint indexOne;
        address toOne;
    }

    struct DataTwo {
        uint indexTwo;
        address toTwo;
    }

    DataOne dataOne;
    DataTwo dataTwo;


    function getDataOne() public view returns (DataOne memory) { 
        return dataOne; 
    }

    function getDataTwo() public view returns (DataTwo memory) { 
        return dataTwo; 
    }
}


