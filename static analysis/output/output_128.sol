pragma solidity ^0.8.9;
contract TestContract {
    string public data;

    function test_storage(string memory _data) public {
        data = _data;
    }
}

