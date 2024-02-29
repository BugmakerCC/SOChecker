pragma solidity ^0.8.9;
contract StudentContract {
    struct Student {
        uint id;
        string name;
        string class;
    }

    address public owner;
    uint public studentsCounter;

    mapping (uint => mapping (address => Student)) public Info;
    Student[] public student_Info;

    constructor() public {
        owner = msg.sender;
    }

    function addInfo(Student memory _student, address _address) public returns(uint){
        require(owner == msg.sender, "Only admin can add Info!!!");
        Info[studentsCounter][_address] = _student;
        studentsCounter++;
        student_Info.push(_student);
        return studentsCounter-1;
    }

    function addInfoToAddress(Student memory _student, address _address) public {
        require(owner == msg.sender, "Only admin can add Info!!!");
        Info[studentsCounter][_address] = _student;
        student_Info.push(_student);
    }
}

