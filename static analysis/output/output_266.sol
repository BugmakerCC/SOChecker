pragma solidity ^0.8.9;
contract A {
    function foo() public pure virtual returns (string memory) {
           return "Foo Contract A";
    }

    function bar() public pure returns (string memory) {
          return "Bar Contract A";
    }
}

