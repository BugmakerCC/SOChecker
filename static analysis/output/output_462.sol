pragma solidity ^0.4.25;
contract SimpleTransfer {
    function send(address recipient, uint256 amount) public {
        recipient.transfer(amount);
    }
}

