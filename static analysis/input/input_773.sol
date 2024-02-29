pragma solidity 0.8.19;

interface MyInterface{
    function changeVariable() external;
    function randomFunction() external;
}

contract ContractInherits {
    uint256 public a_variable;

    function changeVariable() public {
        a_variable = a_variable++;
    }  
}

contract MainContract {
    MyInterface public immutable instanceOfContractInherits;

    constructor(MyInterface _ContractInherits) {
        instanceOfContractInherits = _ContractInherits;
    }

    function doStuff() public {
        instanceOfContractInherits.changeVariable();
        instanceOfContractInherits.randomFunction();
    }
}


transact to MainContract.doStuff errored: VM error: revert.

revert

status  false Transaction mined but execution failed


