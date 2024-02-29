contract Users {
    struct User {
        string username;
        uint[] grades;
        address byWhom;
        uint timestamp;
    }
    mapping(string => User) userMap;

    event userDetailsChanged(
        string username,
        uint grade
    );
    function setUserDetails(string memory _username, uint _grade) external {
        // if _username exists add your logic 
        // i cannot just write this: userMap[_username]. it cannot be convertible bool because if it does not exists, evm will return struct with default values
        if(userMap[_username].grades.length==0){
            User storage currentUser=userMap[_username];
            currentUser.grades.push(_grade);
            return;
        } 
        userMap[_username].username = _username;
        userMap[_username].grades.push(_grade);
        // you might need to add restriction rule to allow certain people to call this function.
        // msg.sender is the caller of this function
        userMap[_username].byWhom=msg.sender;
        userMap[_username].timestamp=block.timestamp;
        

        // YOU COULD ALSO DO THIS 
        // userMap[_username]=User(
        //     _username,
        //     _grade,
        //     msg.sender,
        //     block.timestamp
        // )
        emit userDetailsChanged(_username, _grade);
    }

    function getUserGrades(string memory _username) external view returns(uint[] memory _grades) {
        return (
            userMap[_username].grades
        );
    }
}

