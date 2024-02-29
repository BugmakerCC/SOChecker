pragma solidity ^0.8.9;
contract A {
    
    function getBValue() external view returns (uint256) {
        uint256 BValue = B(address(0x123)).getValue();
        return BValue;
    }
}

contract B {
    
    function getValue() external view returns (uint256) {
        return 1; 
    }
    
}

