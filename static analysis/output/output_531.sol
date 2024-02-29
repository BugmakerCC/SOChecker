pragma solidity ^0.8.9;
contract MyContract {
    struct people {
        uint num;
        string name;
    }

    people[] public person;

    function plus(uint _num, string memory _name) public {
        person.push(people(_num, _name));
    }
}

