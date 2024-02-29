function withdraw(uint256 _amount) external {
    balances[msg.sender] -= _amount;
    (bool success, ) = payable(msg.sender).call{value: _amount}("");
}

(bool success, ) = payable(msg.sender).call{value: _amount}("");
require(success);

function withdraw(uint256 _amount) external {
    balances[msg.sender] -= _amount;
    payable(msg.sender).transfer(_amount);
}


