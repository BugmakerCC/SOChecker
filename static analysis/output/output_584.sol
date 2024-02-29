pragma solidity ^0.8;

contract MyContract {
    struct Foo {
        string foo1;
    }

    // implicit `storage` location of the property
    Foo foo1 = Foo("foo");

    function myFunction() public {
        // need to explicitly state location of the variable
        Foo memory foo2 = Foo("foo"); 
    }
}

