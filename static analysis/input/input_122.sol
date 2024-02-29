function setStudentRecords(string calldata _name, string calldata _address, string calldata _phoneNumber, uint16 _rollNumber,
                              string calldata _DOB, uint8 _sem, uint8 _CGPA, string calldata _UniName) public
{
    StudentRecord.push(  
        student(         
            _name,
            _address,
            _phoneNumber,
            _rollNumber,
            _DOB,
            _sem,
            _CGPA,
            _UniName
        )
    );
}


