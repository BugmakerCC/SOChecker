pragma solidity ^0.8;

contract MyContract {
    address owner = address(0x123);

    function foo() external payable {
        require(msg.value == 1e18);

        payable(owner).transfer(msg.value);
    }
}


