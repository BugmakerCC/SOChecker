pragma solidity ^0.8;

contract MyContract {
    mapping (address => uint256) contributions;

    receive() external payable {
        contributions[msg.sender] += msg.value;
    }
}


