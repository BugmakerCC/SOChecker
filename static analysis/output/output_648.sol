pragma solidity ^0.8.9;
contract Parent {
    function foo() virtual public pure returns (uint) {
        return 1;
    }
}

