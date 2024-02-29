modifier callerIsUser() {
  require(tx.origin == msg.sender, "The caller is another contract");
  _;
}

function example() callerIsUser {
  ...
}


