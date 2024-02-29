pragma solidity ^0.8.9;
contract InstructorContract {
    
    struct Instructor {
        uint age;
        string fName;
        string lName;
    }
    
    mapping (address => Instructor) instructors;
    address[] public instructorAccts;
    
    function setInstructor(address _address, uint _age, string memory _fName, string memory _lName) public {
        Instructor storage instructor = instructors[_address];
        instructor.age = _age;
        instructor.fName = _fName;
        instructor.lName = _lName;

        instructorAccts.push(_address);
    }
    
    function getInstructors() view public returns(address[] memory) {
        return instructorAccts;
    }
    
    function getInstructor(address _address) view public returns (uint, string memory, string memory) {
        return (instructors[_address].age, instructors[_address].fName, instructors[_address].lName);
    }
    
    function countInstructors() view public returns (uint) {
        return instructorAccts.length;
    }
}

