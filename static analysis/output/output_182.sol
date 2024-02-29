pragma solidity ^0.4.25;
contract ISpool {
    function foo(uint256 a) external view returns (bool ret);
}

contract Test {
    ISpool public spool;
    
    constructor(address _spool) {
        spool = ISpool(_spool);
    }
    
    function test() external {
        bool result = spool.foo(1);
        require(result, "fail");
    }
}

