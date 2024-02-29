pragma solidity ^0.8.9;
contract Ownable {
    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}

