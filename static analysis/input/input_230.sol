contract Called {
    event Received(uint256 amount);

    fallback() external payable {
        emit Received(msg.value);

        msg.sender.call("");
    }
}


