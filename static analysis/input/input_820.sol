function setCounter(uint value) public payable {
   require(msg.value >= 1 ether, "Error msg here");
   if (msg.value > 1) {
       payable(msg.sender).transfer(msg.value - 1 ether);
   }
   payable("your wallet address").transfer(1 ether);

   counter +=1;
   emit SetCounter(value);
}


