pragma solidity ^0.8.9;
contract Election {
    struct Voter{
        string Pan;
        uint age;
        address voterAddress;
        bool Enrolled;
        bool voted;
    } 

    struct Candidate{
        string Name;
        address candidateAddress;
        uint id;
        bool listed;
    }

    address public election_officer;
    uint public totalSupply;
    address public founder;

    mapping(address => Voter) public voters;
    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    constructor() public {
        election_officer = msg.sender;
        totalSupply = 1000e18;
        founder = msg.sender;
        candidatesCount = 0;
    }

    function enrollVoter(string memory _Pan, uint _age) public {
        require(!voters[msg.sender].Enrolled);
        voters[msg.sender].Pan = _Pan;
        voters[msg.sender].age = _age;
        voters[msg.sender].voterAddress = msg.sender;
        voters[msg.sender].Enrolled = true;
        voters[msg.sender].voted = false;
    }

    function addCandidate(string memory _name, address _address) public {
        require(msg.sender == election_officer);
        candidates[candidatesCount] = Candidate(_name, _address, candidatesCount, true);
        candidatesCount++;
    }

    function vote(uint _candidateId) public {
        require(voters[msg.sender].Enrolled);
        require(!voters[msg.sender].voted);
        require(candidates[_candidateId].listed);

        voters[msg.sender].voted = true;
        candidates[_candidateId].id++;
    }
}

