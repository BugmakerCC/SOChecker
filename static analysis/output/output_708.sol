pragma solidity ^0.8.9;
contract MyContract {
    struct Info {
        uint64 lastused;
        uint256 limit;
        string comment;
        address[] allowedTo;
    }

    mapping (address => Info) public users;

    function setUser(address user, uint64 lastused, uint256 limit, string calldata comment, address[] calldata allowedTo) external {
        users[user] = Info(lastused, limit, comment, allowedTo);
    }

    function getAllowedTo(address user) external view returns (address[] memory) {
        return users[user].allowedTo;
    }
}

