pragma solidity ^0.8;

contract Hello {
    constructor(string memory text1, string memory text2) {}
}

contract World {
    function foo() external {
        new Hello("constructor", "params");

        Hello(address(0x123));
    }
}


