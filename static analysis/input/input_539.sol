balances[msg.sender] = 0;

msg.sender.transfer(balances[msg.sender]);

uint256 balance = balances[msg.sender];
balances[msg.sender] = 0; 
msg.sender.transfer(balance); 


