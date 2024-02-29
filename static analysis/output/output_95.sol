pragma solidity ^0.8.9;
contract TestStruct {

    struct TestStruct {
        string a;
        string b;
    }

    mapping (address => TestStruct) public tests;

    function updateStructA(string memory _newValue) public {
        tests[msg.sender].a = _newValue;
    }

    function updateStructB(string memory _newValue) public {
        tests[msg.sender].b = _newValue;
    }
}

