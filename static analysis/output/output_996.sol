pragma solidity ^0.8;

contract MyContract {
    uint256 numberA = 1; // slot 0
    uint256 numberB = 1; // slot 1
    uint256 numberC = 1; // slot 2

    uint128 numberD = 1; // slot 3
    uint128 numberE = 1; // slot 3

    // length in slot 4
    // values in slot ID determined by hash of the position + offset
    // in this case keccak256(4) + 0, keccak256(4) + 1, and keccak256(4) + 2
    uint256[] numbers;

    constructor() {
        numbers.push(2);
        numbers.push(3);
        numbers.push(4);
    }
}

