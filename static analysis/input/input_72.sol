function addStudentDetails (string memory _studentFirstName, string memory _studentLastName) public onlyClassTeacher(msg.sender){
            StudentDetails storage studentObj = students[studentCount];
    
            studentObj.studentFirstName = _studentFirstName;
            studentObj.studentLastName = _studentLastName;
            studentObj.id = studentCount;
            emit studentAdded(_studentFirstName, _studentLastName, msg.sender, studentCount);
            studentCount++;
        }


