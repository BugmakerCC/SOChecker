pragma solidity ^0.8;

contract ContractA {
    address contractB;
    
    modifier onlyContractB {
        require(msg.sender == contractB);
        _;
    }

    function foo() external onlyContractB {
    }
    
    function setContractBAddress(address _contractB) external {
        contractB = _contractB;
    }
}

pragma solidity ^0.8;

interface IContractA {
    function foo() external;
}

contract ContractB {
    IContractA contractA;
    
    constructor(address _contractA) {
        contractA = IContractA(_contractA);
    }

    function callFoo() external {
        contractA.foo();
    }

}

