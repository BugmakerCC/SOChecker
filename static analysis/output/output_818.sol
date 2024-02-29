pragma solidity ^0.8.9;
contract KeepData {
    // Define a function called getData() that returns multiple values
    function getData() public pure returns (uint, uint, uint, uint, string memory, uint, uint) {
        return (1, 2, 3, 4, "data", 5, 6);
    }
}

contract MyContract {
    KeepData keepData;

    // Constructor to initialize the KeepData contract
    constructor(KeepData _keepData) public {
        keepData = _keepData;
    }

    function doSomething() external {
        string memory d5;
        (,,,,d5,,) = keepData.getData();
        // Do something with d5
    }
}

