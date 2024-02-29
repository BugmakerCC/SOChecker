pragma solidity ^0.8.9;
abstract contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () internal {
        address msgSender = msg.sender;
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    modifier onlyOwner() {
        require (_owner == msg.sender, "Ownership not transferred");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner can't be address zero.");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract CreatureList {
    address[] public creatureList;    
}

