pragma solidity ^0.7.6;
contract Counter {
    uint public counter;
    address payable public owner;

    event SetCounter(uint value);

    constructor() public {
        owner = msg.sender;
    }

    function setCounter(uint value) public payable {
        require(msg.value >= 1 ether, "Error msg here");

        if (msg.value > 1 ether) {
            payable(msg.sender).transfer(msg.value - 1 ether);
        }

        owner.transfer(1 ether);

        counter = value;
        emit SetCounter(value);
    }

    function getCounter() public view returns (uint) {
        return counter;
    }
}

