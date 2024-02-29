 function createUser( string memory _userName) public {
    MyUser memory user;
    user.publicKey = msg.sender;
    user.userName = _userName;
    users.push(user);
 }


