pragma solidity ^0.8;

contract MyContract {
    address owner = address(0x123);

    // `payable` modifier allows the function to accept ETH
    function foo() external payable {
        // validate that the received amount is 1e18 wei (1 ETH)
        require(msg.value == 1e18);

        // typecast `address` variable (name `owner`)
        // to `address payable` and effectively redirect the received value
        // with the native `transfer()` function of the `address payable` type
        payable(owner).transfer(msg.value);
    }
}

