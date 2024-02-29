pragma solidity ^0.8;

contract MyContract {
    function foo() external {
        borrow(uint256(getLatestPrice()));
    }
    
    function getLatestPrice() internal returns (int256) {
        return 1;
    }
    
    function borrow(uint256 _number) internal {
    }
}


