pragma solidity ^0.4.25;
contract SimpleStorage {

    address private owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function setOwner(address _newOwner) public {
        require(msg.sender == owner, "Only owner can set new owner");
        require(_newOwner != owner, "New owner cannot be the same as current owner");
        owner = _newOwner;
    }

    function() external payable {}
}

