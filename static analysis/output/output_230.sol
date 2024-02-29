pragma solidity ^0.8.9;
contract Called {
    event Received(uint256 amount);

    fallback() external payable {
        // ok
        emit Received(msg.value);

        // fail - costs more than the 2300 limit
        msg.sender.call("");
    }
}

