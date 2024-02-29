pragma solidity ^0.8.9;
contract Debugging {
    uint256 counter;
    constructor(uint256 _counter) {
        counter = _counter;
    }

    function increaseCounter() public {
        counter += 1;
    }
}
