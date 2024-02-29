// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Person{
    string public FirstName;
    string public LastName;
}

contract Family{
    Person[] public People;

    function addPerson(Person person) public {
        People.push(person);
    }
}

contract FamilyManager{
    Family[] Families;

    function AddFamily(Person[] memory people) public {
        Family family = new Family();
        for(uint x; x < people.length; x++) {
            family.addPerson(people[x]);
        }
        Families.push(family);
    }

    function GetFamilies() public view returns (Family[] memory){
        return Families;
    }
}


