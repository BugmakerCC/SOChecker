pragma solidity ^0.8;

interface I {
    function foo() external;
}

contract C is I {
    function foo() override external {
    }

    function otherFunction() external {
    }
}

contract Factory {
    function deploy() external {
        I i = new C();
        i.foo();

        C c = new C();
        c.foo();
        c.otherFunction();
    }
}


