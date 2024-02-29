pragma solidity ^0.8;

contract Escrow {
    address holder;
    address admin;

    receive() external payable {}

    function withdraw(uint256 _amount) external {
        require(msg.sender == holder || msg.sender == admin);
        payable(msg.sender).transfer(_amount);
    }
}


