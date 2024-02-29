modifier onlyAllowedUsers {
  require(validUser[msg.sender] || admin == msg.sender, "Error Message");
  _;
}


