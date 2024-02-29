pragma solidity ^0.8;

contract Hello {
    constructor(string memory text1, string memory text2) {}
}

contract World {
    function foo() external {
        // deploying new contract
        new Hello("constructor", "params");

        // pointing to an already deployed contract
        Hello(address(0x123));
    }
}

