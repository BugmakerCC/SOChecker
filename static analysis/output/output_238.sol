pragma solidity ^0.8.9;
contract SimpleStorage {

    uint256 public count;

    function increment() public {
        count++;
    }
}

