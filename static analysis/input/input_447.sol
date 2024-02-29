pragma solidity ^0.8;

contract MyContract {
    uint256[] numbers;

    constructor() {
        numbers.push(123);
        numbers.push(456);
    }

    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }
}


