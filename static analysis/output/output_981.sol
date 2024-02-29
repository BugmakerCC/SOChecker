pragma solidity ^0.8.9;
contract Test {
    function foo() external pure returns (uint256 ret) {
        return 123;
    }

    function bar() external pure returns (uint256 ret) {
        return 456;
    }

    function baz() external pure returns (uint256 ret) {
        return 789;
    }

    function qux() external pure returns (uint256 ret) {
        return 1010;
    }
}

