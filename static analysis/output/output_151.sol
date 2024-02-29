pragma solidity ^0.8;

interface I {
    function foo() external;
}

contract C is I {
    function foo() override external {
        // implements the `foo()` function of the `I` interface
    }

    function otherFunction() external {
    }
}

contract Factory {
    function deploy() external {
        // the `I` type variable `i` can only invoke the `foo()` function
        I i = new C();
        i.foo();

        // the `C` type variable `c` can invoke the `otherFunction()` as well
        C c = new C();
        c.foo();
        c.otherFunction();
    }
}

