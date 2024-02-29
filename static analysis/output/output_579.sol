pragma solidity ^0.4.25;
contract ProposalVoter {
 struct ProposalVote {
    bool isTrue;
    uint256[] votes;
    mapping(address => bool) hasVoted;
 }
    
mapping(address => ProposalVote) public votes;
 
    function propose(bool _proposal) public {     
      votes[msg.sender].isTrue = _proposal;
      votes[msg.sender].votes.push(msg.value);
      votes[msg.sender].hasVoted[msg.sender] = true;     
    }    
}

