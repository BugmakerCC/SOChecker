pragma solidity 0.8.21;

contract MyContract {
    function foo(string calldata someInput) external {
        someInput = "hello";
    }

    function foo2(string memory someInput) external pure {
        someInput = "hello";
    }
}


