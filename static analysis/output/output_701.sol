pragma solidity ^0.8.9;
contract UserList {

    struct MyUser {
        address publicKey;
        string userName;
    }

    MyUser[] public users;

    function createUser( string memory _userName) public {
    MyUser memory user;
    user.publicKey = msg.sender;
    user.userName = _userName;
    users.push(user);
    }

}

