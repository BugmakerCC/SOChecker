pragma solidity ^0.8.9;
contract MyContract {
    struct Admin {
        bool _isDeleted;
    }

    mapping(address => Admin) public adminMembers;

    function myFunction(address admin) external view returns (bool) {
       return adminMembers[admin]._isDeleted;
    }
}

