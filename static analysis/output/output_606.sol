pragma solidity ^0.8.9;
contract SimpleStorage {
    uint public data;

    function store(uint _data) public {
        data = _data;
    }

    function retrieve() public view returns (uint) {
        return data;
    }
}

