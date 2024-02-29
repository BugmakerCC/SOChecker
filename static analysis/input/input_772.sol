pragma solidity ^0.8;

contract MyContract {
    function foo() external {
        require(false, "Only owner can call this function xxxxxxxxxx");
    }
}

pragma solidity ^0.8;

contract MyContract {
    function foo() external {
        require(false, "no");
    }
}


