pragma solidity ^0.8.9;
contract MyContract {
    string public someInput;

    function foo(string calldata _someInput) external {
        someInput = _someInput;
    }

    function foo2(string calldata _someInput) external pure returns (string memory) {
        return _someInput;
    }
}

