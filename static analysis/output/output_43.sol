pragma solidity ^0.8.9;
library Lib {

    struct LibPerson {
        mapping(address => Person) mapPerson;
    }

    struct LibCompany {
        mapping(address => Company) mapCompany;
    }

    struct Person {
        address addr;
        string name;
        string surname;
    }

    struct Company {
        address addr;
        string name;
    }

    function addPerson(LibPerson storage lp, address addr, string memory name, string memory surname) public{
        addr = msg.sender;
        lp.mapPerson[addr] = Person(addr, name, surname);
    }

    function addCompany(LibCompany storage lc, address addr, string memory name) public{
        addr = msg.sender;
        lc.mapCompany[addr] = Company(addr, name);
    }    

    function getCompany(LibCompany storage lc, address addrFind) view external returns(address){
        return lc.mapCompany[addrFind].addr;
    }   

    function getPerson(LibPerson storage lp, address addrFind) view external returns(address){
        return lp.mapPerson[addrFind].addr;
    }     
}

