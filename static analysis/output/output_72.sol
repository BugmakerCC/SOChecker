pragma solidity ^0.8.9;
contract School {
    struct StudentDetails {
        string studentFirstName;
        string studentLastName;
        uint id;
    }

    mapping(uint => StudentDetails) public students;
    uint public studentCount;

    address public classTeacher;

    event studentAdded (
        string studentFirstName,
        string studentLastName,
        address indexed addedBy,
        uint id
    );

    constructor() public{
        classTeacher = msg.sender;
    }

    modifier onlyClassTeacher(address _address) {
        require(_address == classTeacher, "Only class teacher can add students");
        _;
    }

    function addStudentDetails (string memory _studentFirstName, string memory _studentLastName) public onlyClassTeacher(msg.sender) {
        StudentDetails storage studentObj = students[studentCount];

        studentObj.studentFirstName = _studentFirstName;
        studentObj.studentLastName = _studentLastName;
        studentObj.id = studentCount;
        emit studentAdded(_studentFirstName, _studentLastName, msg.sender, studentCount);
        studentCount++;
    }
}

