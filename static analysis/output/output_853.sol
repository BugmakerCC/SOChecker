pragma solidity ^0.4.25;
contract SafeTransfer {

    function transferEther(address recipient, uint amount) public {
        require(msg.sender.balance > 0 ether,"You  Broke");
        recipient.transfer(amount);
    }
}

