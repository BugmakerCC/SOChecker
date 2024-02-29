pragma solidity ^0.8.9;
contract iFollow {
    address private _owner;

    constructor(address owner) {
        _owner = owner;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Not the owner of this contract");
        _;
    }
}

