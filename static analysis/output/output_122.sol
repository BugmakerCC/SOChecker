pragma solidity ^0.7.6;
contract StudentRecords {
    struct Student {
        string name;
        string addr;
        string phoneNumber;
        uint16 rollNumber;
        string DOB;
        uint8 sem;
        uint8 CGPA;
        string UniName;
    }

    Student[] public StudentRecord;

    function setStudentRecords(string calldata _name, string calldata _address, string calldata _phoneNumber, uint16 _rollNumber,
                              string calldata _DOB, uint8 _sem, uint8 _CGPA, string calldata _UniName) public
    {
        StudentRecord.push(Student(         
            _name,
            _address,
            _phoneNumber,
            _rollNumber,
            _DOB,
            _sem,
            _CGPA,
            _UniName
        ));
    }
}

