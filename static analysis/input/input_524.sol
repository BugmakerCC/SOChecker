pragma solidity ^0.8.0;

contract Ballot {
    struct Candidate {
        address _address;
        uint256 _noOfVotes;
    }

    address private chairperson;
    Candidate[] public candidateList;
    mapping(address => bool) private isInVoterList;
    mapping(address => address) private voterToCandidate;

    modifier isOwner() {
        require(msg.sender == chairperson);
        _;
    }

    modifier isVoter(address voterAddress_) {
        require(
            voterAddress_ == msg.sender,
            "The voter must register by itself..."
        );
        _;
    }

    modifier voterRules() {
        require(msg.sender != chairperson, "Chairperson cannot vote!!");
        require(isInVoterList[msg.sender], "You must register yourself first");
        for (uint256 k = 0; k < candidateList.length; k++) {
            require(
                voterToCandidate[msg.sender] != candidateList[k]._address,
                "You cannot vote twice..."
            );
        }

        _;
    }

    constructor() {
        chairperson = msg.sender;
    }

    function addCandidate(address address_) public isOwner {
        for (uint256 i = 0; i < candidateList.length; i++) {
            require(
                address_ != candidateList[i]._address,
                "Same Candidate cannot be added twice"
            );
        }
        Candidate memory candidate = Candidate(address_, 0);
        candidateList.push(candidate);
    }

    function registerVoter(address voterAddress_)
        external
        isVoter(voterAddress_)
    {
        require(
            isInVoterList[voterAddress_] == false,
            "You are already registerd voter"
        );
        isInVoterList[voterAddress_] = true;
    }

    function vote(uint256 _candId) public voterRules {
        voterToCandidate[msg.sender] = candidateList[_candId]._address;
        candidateList[_candId]._noOfVotes++;
    }
}


