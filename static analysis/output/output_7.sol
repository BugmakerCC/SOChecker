pragma solidity ^0.8.9;
contract TeamContract {
    struct Team {
        string engineer;
        mapping (string => uint) numbers;
    }

    mapping(string => Team) teams;

    function addEngineer(string memory _teamId, string memory _engineer) public {
        Team storage team = teams[_teamId];
        team.engineer = _engineer;
    }

    function addNumber(string memory _teamId, string memory _numberId, uint _number) public {
        Team storage team = teams[_teamId];
        team.numbers[_numberId] = _number;
    }

    function getEngineer(string memory _teamId) public view returns (string memory) {
        return teams[_teamId].engineer;
    }

    function getNumber(string memory _teamId, string memory _numberId) public view returns (uint) {
        return teams[_teamId].numbers[_numberId];
    }
}

