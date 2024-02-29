 enum VotingOption {
    Confirmed,
    Abstention
}

struct Votes {
    uint256 total;
    uint256 totalPercentage;
}

struct Elector {
    address wallet;
    VotingOption votingOption;
    
}

struct Candidate {
    uint256 number;
    string avatar;
    Votes confirmedVotes;
}

contract ElectronicVotingMachine {

mapping (address => Elector) public electorsWhoVoted;

Votes abstentionVotes = Votes({ total: 0, totalPercentage: 0 });
Elector[] electors;
Candidate[] candidates;
string[] candidateAvatar = [
    "https:
    "https:
    "https:
    "https:
    "https:
    "https:
];

function _createCandidates() private {
    for(uint256 index = 0; index <= 6; index++) {
        candidates.push(Candidate({
            number: index + 1,
            avatar: candidateAvatar[index],
            confirmedVotes: Votes({ total: 0, totalPercentage: 0 })
        }));
    }
}

constructor() {
    _createCandidates();
}


