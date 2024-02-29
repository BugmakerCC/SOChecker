
pragma solidity ^0.8.0;

contract FallbackContract {
    uint256 public invalidFunctionCalls;

    constructor () {
        invalidFunctionCalls = 0;
    }

    fallback() external {
        invalidFunctionCalls += 1;
    }
}


