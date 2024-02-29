pragma solidity ^0.8.9;
interface SimpleStorage {
    function store(uint256) external;
}

contract SimpleStorageArray {
    address[] public simpleStorageArray;

    function init(address _simpleStorage) external {
        simpleStorageArray.push(_simpleStorage);
    } 
}

