struct ProposalVote {
    bool isTrue;
    uint256[] votes;
    mapping(address => bool) hasVoted;
}


