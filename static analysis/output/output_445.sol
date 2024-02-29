pragma solidity ^0.8.9;
contract ContractA {
    event Received(address sender, uint value);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function deposit() public payable{
        require(msg.value >= 0, "Value amount to be deposit");
        withdraw(msg.value);
    }

    function withdraw(uint256 _amount) internal{
        uint256 amount = 2 * _amount; 
        payable(msg.sender).transfer(amount);
    }
}

