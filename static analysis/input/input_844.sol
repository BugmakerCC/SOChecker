function purchaseCard(uint _id) public {
   User storage user = users[msg.sender];
   if (!checkExistedUser(msg.sender)) {
     user.exist = true;
     user.numberOfCards = 0;
   }
   user.purchase.push(Purchase(cards[_id], block.timestamp));
   user.numberOfCards++;
}


