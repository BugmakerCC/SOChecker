contract YourContract {
    function pullTokens() external {
        tokenContract.transferFrom(msg.sender, address(this), amount);
    }
}


