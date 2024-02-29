//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank {
    uint256 public amountIn;
    function deposit() external payable returns(uint256) {
        amountIn = msg.value ;
        return amountIn;
    }
    // receive() external payable{}
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}


interface Receiver {
    function deposit() external payable returns(uint256);
}

contract Sender {
    Receiver private receiver ;
    constructor(address _receiver){
        receiver=Receiver(_receiver);
    }

    function sendDeposit(uint256 _amount) public payable {
        receiver.deposit{value: _amount}();
    }

    receive() external payable {
         require(msg.value > 0, "You cannot send 0 ether");
    }

 }

