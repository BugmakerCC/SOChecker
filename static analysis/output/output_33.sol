pragma solidity ^0.8.9;
library Counters {

  struct Counter {
    uint256 _value;
    uint256 _maxValue;
  }

  function increment(Counter storage counter) internal {
    if (counter._value >= counter._maxValue) revert();
    counter._value++;
  }

  function decrement(Counter storage counter) internal {
    if (counter._value == 0) revert();
    counter._value--;
  }

  function valueOf(Counter storage counter) internal view returns (uint256) {
    return counter._value;
  }

}

