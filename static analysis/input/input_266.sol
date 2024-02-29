
pragma solidity 0.8.7;
contract A {
    function foo() public pure virtual returns (string memory) {
           return "Foo Contract A";
    }

    function bar() public pure returns (string memory) {
          return "Bar Contract A";
    }
contract B is A {
    function foo() public pure override returns (string memory) {
         return "Foo Contract B";
    }
}

contract B is A {}


