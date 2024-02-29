pragma solidity ^0.8.9;
contract Election {
    struct Candidate {
        uint numVotes;
        string name;
    }

    mapping (address => Candidate) public candidates;
    mapping (address => address) public votes;

    function addCandidate(string memory _name) public {
        candidates[msg.sender].name = _name;
    }

    function castVote(address _address) public {
        require(_address != msg.sender, "Candidates cannot vote for themselves");

        votes[msg.sender] = _address;
        Candidate storage candi = candidates[_address];
        candi.numVotes = candi.numVotes + 1;
    }
}

