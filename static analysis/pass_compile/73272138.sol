//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0<0.9.0;

contract Withdraw {
    constructor() payable {}

    function withdrawByTransfer(uint256 amount) public payable {
        payable(msg.sender).transfer(amount);
    }

    function withdrawBySend(uint256 amount) public payable {
        bool success = payable(msg.sender).send(amount);
        require(success, "Failed to send Ether");
    }

    function withdrawByCall(uint256 amount) public returns(bytes memory) {
        (bool success, bytes memory result) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed to withdraw Ether");

        return result;
    }
}

