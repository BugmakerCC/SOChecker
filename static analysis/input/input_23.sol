function mint() payable public returns (uint256) {
  require(msg.value == 0.1 ether || msg.value == 100000000000000000 
    wei, "Transaction amount has to be 0.1 eth");

  payable(this).transfer(msg.value);

  _safeMint(msg.sender, token_id);

  token_id.increament();

  return token_id;
}


