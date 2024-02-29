pragma solidity ^0.8.9;
contract UserStorage {
    uint[4] public idUserStorage;
    mapping(address => UserStorageUser) public userDetails;

    struct UserStorageUser {
        address id;
        uint256 timestamp;
        uint256 bal;
        uint8 index;
    }
}

