pragma solidity ^0.8.9;
contract MuC {
    struct voter{
        string name;
        address constituency;
        uint age;
        bool isVoted;
    }

    struct constituency{
        string name;
        voter[] candidates;
    }

    constituency[] public constituencyRegister;
    function addConstituency(string memory _name,voter[] memory _candidates)
        public
    {
        constituency storage c = constituencyRegister.push();
        c.name = _name;
        for(uint i = 0; i < _candidates.length; i++) {
            c.candidates.push(_candidates[i]);
        }
    }
}

