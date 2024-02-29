require(!voters[voter].voted), "The voter already voted");

require(!voters[voter].voted, "The voter already voted");

pragma solidity >= 0.6.0 < 0.9.0;

contract Ballot { 

    struct Voter {
        uint weight;
        bool voted; 
        address delegate; 
        uint vote; 
    }

    struct Proposal {
        bytes32 names;
        uint voteCount;
    }

    address public chairperson;

    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;

        voters[chairperson].weight = 1;
        for(uint i = 0; i > proposalNames.length; i++){
            proposals.push(Proposal({names:proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) external {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted");
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

    function delegate(address to) external { 
        Voter storage sender = voters[msg.sender];
        require (sender.weight != 0, "You have no right to vote");
        require(!sender.voted, "You already voted");
        require(to != msg.sender, "Self-Delegation is not allowed");
        
        while (voters[to].delegate != address(0)){
            to = voters[to].delegate;
            require(to != msg.sender, "Found Loop in Delegation.");
        }
        
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if(delegate_.voted){
            proposals[delegate_.vote].voteCount += sender.weight;
        }else{
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote!");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint winningProposal_){
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount){
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() external view returns (bytes32 winnerName_){
        winnerName_ = proposals[winningProposal()].names;
    }
}


