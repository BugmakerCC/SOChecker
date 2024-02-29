...
mapping( address => uint ) balances;
function sendToken(address user, uint amount) public payable {
    balances[msg.sender] = amount;
...
}

function retireMyCoins() public {
   uint amountToWithdraw = balances[msg.sender]
   balances[msg.sender] = 0; 
   msg.sender.transfer(amountToWithdraw); 
}


