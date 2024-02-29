pragma solidity ^0.8;

contract MyContract {
    function mint() external {
        require(block.timestamp >= 1640995200, "Not yet available");
    }
}


