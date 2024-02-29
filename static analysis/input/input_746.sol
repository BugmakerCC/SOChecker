function persons(uint256 _index) external view returns (Person memory);

interface IContractA {
    struct Person {
        string name;
    }
    function person(uint256 _index) external view returns (Person memory);
}

contract ContractA {
    struct Person {
        string name;
    }

    Person[] public persons;

    function createPerson(string memory _name) public {
        persons.push(Person(_name));
    }
    function person(uint _index) external view returns (Person memory) {
        return persons[_index];
    }
}

contract ContractB {
    address contractAddress = 0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B;

    function getPerson(uint256 _index)
        public
        view
        returns (IContractA.Person memory)
    {
        IContractA contractAIns = IContractA(contractAddress);
        return contractAIns.person(_index);
    }
}


