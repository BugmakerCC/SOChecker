// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter { 
    uint public Count = 0;
    // NOTE: I changed name to these two events
    event EventIncrement(uint value);
    event EventDecrement(uint value);

    function getCount() view public returns(uint) {
        return Count;
    }

    function Increment() public {
        Count += 1;
        emit EventIncrement(Count);
    }

    function Decrement() public {
        Count -= 1;
        emit EventDecrement(Count);
    }
}

