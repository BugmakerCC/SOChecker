function getUser(address _userAddress)
        public
        view
        onlyAuthCaller
        returns (
            string memory name,
            string memory info,
            string memory role,
        )
    {
        User memory tmpData = userDetails[_userAddress];
        return (
            tmpData.name,
            tmpData.info,
            tmpData.role
        );
    }


