address admin ;

constructor() public {
    admin == msg.sender;
}

modifier isAdmin {
    require(admin == msg.sender,"you are not the owner");
    _;
}


