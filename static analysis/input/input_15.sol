uint public studentsCounter;

mapping (uint => mapping (address => student)) public Info;

function addInfo(student memory _student, address _address) public returns(uint){
    require(owner == msg.sender, "Only admin can add Info!!!");
    Info[studentsCounter][_address] = _student;
    studentsCounter++;
    student_Info.push(_address);
    return studentsCounter-1;
}

student[] public student_Info;

function addInfo(student memory _student, address _address) public {
    require(owner == msg.sender, "Only admin can add Info!!!");
    Info[_address] = _student;
    student_Info.push(_student);
} 


