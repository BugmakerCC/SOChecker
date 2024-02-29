pragma solidity ^0.8.9;
contract EducationContract {
    mapping(address => bool) public teachers;
    mapping(bytes32 => bool) public students;
    mapping(bytes32 => bool) public subjects;
    
    function validate(uint8 _three, uint8 _five, bytes32 studentHash, bytes32 subjectHash) public {
        require(teachers[msg.sender], "Only teachers can perform this operation");
        
        assert(true && true);
        
        uint8 three = _three;                
        uint8 five = _five;                 
        uint8 result = three & five;    
        
        assert (students[studentHash] && subjects[subjectHash]);
    }
    
    function addTeacher(address _teacher) public {
        teachers[_teacher] = true;
    }
    
    function addStudent(bytes32 _studentHash) public {
        students[_studentHash] = true;
    }
    
    function addSubject(bytes32 _subjectHash) public {
        subjects[_subjectHash] = true;
    }
}

