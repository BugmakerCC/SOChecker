pragma solidity ^0.8.9;
contract MyContract {
    function foo() external {
        require(false, "Only owner can call this function xxxxxxxxxx"); 
    }
    function bar() payable public {
        require(msg.sender == address(0), "Only owner can call this function");
    }
}

