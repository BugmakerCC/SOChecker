pragma solidity ^0.8.9;
contract Hospital {

    enum Gender { MALE, FEMALE }

    struct Patient {
        string name;
        uint16 age;
        string telephone;
        string homeAddress;
        uint64 birthday; 
        string disease; 
        Gender gender;
        uint256 createdAt;
    }

    mapping(address => Patient) _patients;

    function setPatients() public {
        Patient memory _patient = Patient({
            name: "test",
            age: 50,
            telephone: "test",
            homeAddress: "test",
            birthday: 1010101010,
            disease: "test",
            gender: Gender.MALE,
            createdAt: block.timestamp            
        });
        _patients[msg.sender] = _patient;
    }

    function getPatient() external view returns(Patient memory) {
        return _patients[msg.sender];
    }

}

