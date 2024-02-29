pragma solidity ^0.8.9;
contract MyContract {
    uint256 myVar;

    constructor() public {
        myVar = 1;
    }

    function getMyVar() public view returns (uint256) {
        return myVar;
    }
}

