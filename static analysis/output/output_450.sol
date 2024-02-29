pragma solidity ^0.8.9;
contract SimplePayment {
    receive() external payable {
        payable(address(this)).transfer(msg.value);
    }
}

