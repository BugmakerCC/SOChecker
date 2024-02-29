pragma solidity ^0.8;

contract ExternalContract {
    function getValue() public {
        revert();
    }
}

contract Caller {
    address externalContractAddress;

    constructor(address _externalContractAddress) {
        externalContractAddress = _externalContractAddress;
    }

    function getExternalValueNamed() public {
        // causes the main transaction to revert
        ExternalContract(externalContractAddress).getValue();
    }

    function getExternalValueCall() public {
        // does not revert the main transaction
        externalContractAddress.call(
            abi.encodeWithSignature("getValue()")
        );
    }
}


