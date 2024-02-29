pragma solidity ^0.8.9;
contract ElectionVoting {
  struct Candidate {
    uint id;
    string name;
    string description;
    uint voteCount;
  }

  mapping(address => bool) public voted;
  
  mapping(uint => Candidate) public candidates;
  
  
  function addVoter() public {
    voted[msg.sender] = false;
  }

  
  function vote(uint _candidateId) public {
    require(!voted[msg.sender], "You have already voted");
    require(candidates[_candidateId].id != 0, "Candidate does not exist");
    voted[msg.sender]= true;
    candidates[_candidateId].voteCount++;
  }
  
}

