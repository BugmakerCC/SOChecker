pragma solidity ^0.8.9;
contract Ownable {
    address private _owner;
    address private _previousOwner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _owner = msg.sender;
        _previousOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function transferOwnership(address newOwner) onlyOwner external {
        _previousOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(_previousOwner, newOwner);
    }
}

