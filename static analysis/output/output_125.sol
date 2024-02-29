pragma solidity ^0.8.9;
contract Test {
    
    
    function callAnotherContract() external {
        address anotherContract = address(0x123);
        bytes memory data = hex"7a1eb1b900";
        uint256 myValue = 0;
        uint256 myGasLimit = 100000;

        anotherContract.call{value: myValue, gas: myGasLimit}(data);
    }
}

