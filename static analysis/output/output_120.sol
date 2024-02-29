pragma solidity ^0.4.25;
contract Admin {
  address private admin;
  mapping (address => bool) validUser;
  bool public admin_set; 

  constructor(address _admin)
  public {
    admin = _admin;
    admin_set = false;
  }

 modifier onlyAllowedUsers {
  require(validUser[msg.sender] || admin == msg.sender, "Error Message");
  _;
}

    function setUser(address _user) public onlyAllowedUsers 
    {
     validUser[_user] = true;
     admin_set = true; 
   }

  function setAdmin(address _admin) public onlyAllowedUsers
  {
    admin = _admin;
    admin_set = true; 
  }

 function() external payable {
    if (!admin_set) 
    {
       admin.transfer(msg.value);
    }
  }
}

