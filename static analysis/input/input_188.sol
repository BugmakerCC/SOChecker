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
        ExternalContract(externalContractAddress).getValue();
    }

    function getExternalValueCall() public {
        externalContractAddress.call(
            abi.encodeWithSignature("getValue()")
        );
    }
}



