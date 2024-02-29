pragma solidity ^0.8.9;
contract StudentInfo {
    struct student {
        uint256 id;
        string name;
        string course;
    }
    
    mapping(bytes32 => student) public studentMap;
    bytes32[] public student_Address;

    function addStudent(uint256 _id, string memory _name, string memory _course, bytes32 _studentAddress) public {
        student memory newStudent = student({
            id: _id,
            name: _name,
            course: _course
        });
        
        studentMap[_studentAddress] = newStudent;
        student_Address.push(_studentAddress);
    }

    function getStudentInfo(uint256 num) public view returns (bytes32, uint256, string memory, string memory) {
        bytes32 key = student_Address[num];
        return (
            key,
            studentMap[key].id,
            studentMap[key].name,
            studentMap[key].course
        );
    }
}

