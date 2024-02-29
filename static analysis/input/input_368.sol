address payable players[].transfer();

uint index = random() % players.length;
uint amount = address(this).balance; 
payable(players[index]).transfer(amount);

uint amount = 0.01 ether;


