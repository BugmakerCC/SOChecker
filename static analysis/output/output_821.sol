pragma solidity ^0.8.9;
contract FirstContract {

    uint public value;

    constructor() public {
        value = 10;
    }

    function setValue(uint amount) public {
        value = amount;
    }

    function getValue() public view returns(uint) {
        return value;
    }
}

