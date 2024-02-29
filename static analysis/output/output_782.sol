pragma solidity ^0.8;

contract MyContract {
    int number = 100; // implicit `storage` location of a property

    function foo() public {
        int anotherNumber = 100; // implicit `memory` location of a variable
    }
}

