pragma solidity ^0.8.9;
contract UserContract {
    struct User {
        string name;
        string info;
        string role;
    }

    address public authCaller;
    mapping(address => User) public userDetails;

    constructor() public {
        authCaller = msg.sender;
    }

    modifier onlyAuthCaller() {
        require(msg.sender == authCaller, "Caller is not authorized");
        _;
    }

    function setUser(address _userAddress, string memory _name, string memory _info, string memory _role) public onlyAuthCaller {
        User memory newUser;
        newUser.name = _name;
        newUser.info = _info;
        newUser.role = _role;
        userDetails[_userAddress] = newUser;
    }

    function getUser(address _userAddress)
        public
        view
        onlyAuthCaller
        returns (
            string memory name,
            string memory info,
            string memory role
        )
    {
        User memory tmpData = userDetails[_userAddress];
        return (
            tmpData.name,
            tmpData.info,
            tmpData.role
        );
    }
}

