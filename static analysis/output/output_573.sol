pragma solidity ^0.8;

contract TargetContract {
    function foo() external pure returns (bool) {
        return true;
    }
}

pragma solidity ^0.8;

interface ITargetContract {
    function foo() external returns (bool);
}

contract SourceContract {
    function baz() external {
        ITargetContract targetContract = ITargetContract(address(0x123));
        bool returnedValue = targetContract.foo();
    }
}

