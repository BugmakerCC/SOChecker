pragma solidity ^0.8.9;
contract Test {
    uint256[] public threshold = [21000, 2000, 3000];

    function setThreshold(uint256[] memory _threshold) public {
        threshold = _threshold;
    }
}

