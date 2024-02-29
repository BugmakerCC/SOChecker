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

    function update(uint _index, uint _newAge, string memory _newName) public returns(uint, string memory) {
        Person memory updatePerson = people[_index];
        updatePerson.age = _newAge;
        updatePerson.name = _newName;
        people[_index] = updatePerson;
        return(updatePerson.age, updatePerson.name);
    }
    
    function destory(uint _index) public {
        delete people[_index];
    }
}


