pragma solidity ^0.8;

contract MyContract {
    receive() external payable {}

    function withdraw() external {
        // transfer this contract's whole BNB balance to the `0x123` address
        payable(address(0x123)).transfer(address(this).balance);
    }
}

