pragma solidity 0.8.9;

contract PAY {
    function sendEther(address payable receiver, uint256 amount) external payable {
        uint val = msg.value;
        require(val >= amount, "Insufficient balance");
        (bool success, ) = receiver.call{value: val}("");
        // receiver.transfer(val);
        require(success, "Failed to send Ether");
    }
}

