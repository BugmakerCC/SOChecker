pragma solidity ^0.8.9;
contract ExampleContract {

    function foo(string calldata _str) public pure returns (string calldata) {
        return _str;
    }

}

