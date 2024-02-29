function delegatedGreeting(address _contract) external {
    (bool success,) = _contract.delegatecall(
        abi.encodeWithSignature("greet()")
    );
    require(success == true, "delegatecall failed");
}


