// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract Dogs {

    struct Person{
        uint age;
        string name;
    }

    Person[] people;

    function addNewPerson(uint _age, string memory _name)public {
        Person memory newPerson = Person(_age, _name);
        people.push(newPerson);
    }

    function getPerson(uint _index)public view returns(uint, string memory){
        Person memory personToReturn = people[_index];
        return(personToReturn.age, personToReturn.name);
    }

    // to replace and old person with a knew person
    function update(uint _index, uint _newAge, string memory _newName) public returns(uint, string memory) {
        Person memory updatePerson = people[_index];
        updatePerson.age = _newAge;
        updatePerson.name = _newName;
        // You can replace the old person at specific index to a new person.
        // You can do it, using the statement declared below this line  
        people[_index] = updatePerson;
        return(updatePerson.age, updatePerson.name);
    }
    
    // delete button for indexs
    function destory(uint _index) public {
        delete people[_index];
    }
}

