pragma solidity ^0.8;

contract MyContract {
    receive() external payable {}

    function withdraw() external {
        payable(address(0x123)).transfer(address(this).balance);
    }
}


