pragma solidity ^0.8;

contract MedicalHistory {
    struct Patient {
        string name;
        uint16 age;
    }

    Patient[] _patients;

    function Register(
        string memory name,
        uint16 age
    ) external {
        Patient memory patient = Patient(name, age);
        _patients.push(patient);
    }
}

