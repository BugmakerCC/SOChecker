pragma solidity ^0.8.9;
contract DelegatedGreeting {
    
    function delegatedGreeting(address _contract) external {
        (bool success,) = _contract.delegatecall(
            abi.encodeWithSignature("greet()")
        );
        require(success == true, "delegatecall failed");
    }

}

