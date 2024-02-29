require(tx.origin == msg.sender)

  TxUserWallet(msg.sender).transferTo(owner, msg.sender.balance);

 require(tx.origin == owner); 


