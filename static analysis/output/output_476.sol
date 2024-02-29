pragma solidity ^0.8.9;
library Person {
    struct Person {
        string name;
        uint256 number;
    }
}

interface IData {
    function getPerson(uint256 id) external view returns (string memory, uint256);
}

