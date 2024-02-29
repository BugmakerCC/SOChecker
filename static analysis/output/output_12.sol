pragma solidity ^0.8.9;
contract MyContract {
    uint256[] public array;

    constructor() {
        array = new uint256[](10);
        for (uint256 i = 0; i < array.length; i++) {
            array[i] = i;
        }
    }

    function loopThroughArray() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < array.length; i++) {
            sum += array[i];
        }
        return sum;
    }
}

