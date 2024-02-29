pragma solidity ^0.8.0;

interface ICounter {
    function increment() external;
}

contract MyContract {
    ICounter counter;

    constructor(address _counter) {
        counter = ICounter(_counter);
    }

    function incrementCount() external {
        counter.increment();
    }
}

