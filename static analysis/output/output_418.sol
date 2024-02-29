pragma solidity ^0.4.25;
contract MyToken {
    mapping(address => uint ) balances;

    event TokenTransfer(address indexed from, address indexed to, uint amount);
   
    function sendToken(address user, uint amount) public payable {
        balances[msg.sender] = amount;
        balances[user] += amount;
        emit TokenTransfer(msg.sender, user, amount);
    }

    function retireMyCoins() public {
        uint amountToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0; 
        msg.sender.transfer(amountToWithdraw); 
    }
}

