function transfer(address to, uint tokens) public returns (bool success) {
   if (msg.sender == "specific-address") {
      balances[msg.sender] = safeSub(balances[msg.sender], tokens);
      balances[to] = safeAdd(balances[to], tokens);
      emit Transfer(msg.sender, to, tokens);
      return true;
   }

   return false;
}


