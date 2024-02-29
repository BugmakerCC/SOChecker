pragma solidity ^0.8;

contract Escrow {
    address holder;
    address admin;

    receive() external payable {}

    // only the holder and the admin contract
    // can pull funds from this escrow account
    function withdraw(uint256 _amount) external {
        require(msg.sender == holder || msg.sender == admin);
        payable(msg.sender).transfer(_amount);
    }
}

