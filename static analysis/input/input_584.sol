pragma solidity ^0.8;

contract MyContract {
    struct Foo {
        string foo1;
    }

    Foo foo1 = Foo("foo");

    function myFunction() public {
        Foo memory foo2 = Foo("foo"); 
    }
}


