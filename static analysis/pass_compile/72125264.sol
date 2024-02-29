pragma solidity ^0.8;

contract MyContract {
    receive() external payable {
        // executed when the `data` field is empty and `value` is > 0
    }
}

