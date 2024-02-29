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
        if(userMap[_username].grades.length==0){
            User storage currentUser=userMap[_username];
            currentUser.grades.push(_grade);
            return;
        } 
        userMap[_username].username = _username;
        userMap[_username].grades.push(_grade);
        userMap[_username].byWhom=msg.sender;
        userMap[_username].timestamp=block.timestamp;
        

        emit userDetailsChanged(_username, _grade);
    }

    function getUserGrades(string memory _username) external view returns(uint[] memory _grades) {
        return (
            userMap[_username].grades
        );
    }
}


