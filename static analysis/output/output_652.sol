pragma solidity ^0.8.9;
contract Ownable {
    address private previousOwner;

    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function reclaimOwnership() external {
        require(msg.sender == previousOwner);
        owner = msg.sender;
    }

    receive() external payable {}

    function transferOwnership(address newOwner) public {
        require(newOwner != address(0));
        emit OwnershipTransferred(previousOwner, newOwner);
        previousOwner = owner;
        owner = newOwner;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
}

