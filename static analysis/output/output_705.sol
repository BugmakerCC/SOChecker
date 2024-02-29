pragma solidity ^0.8.9;
contract ElectronicVotingMachine {
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

    mapping (address => Elector) public electorsWhoVoted;

    Votes abstentionVotes = Votes({ total: 0, totalPercentage: 0 });
    Elector[] public electors;
    Candidate[] public candidates;
    string[] candidateAvatar = [
        "https://example.com/avatar1",
        "https://example.com/avatar2",
        "https://example.com/avatar3",
        "https://example.com/avatar4",
        "https://example.com/avatar5",
        "https://example.com/avatar6"
    ];

    function _createCandidates() private {
        for(uint256 index = 0; index < 6; index++) {
            candidates.push(Candidate({
                number: index + 1,
                avatar: candidateAvatar[index],
                confirmedVotes: Votes({ total: 0, totalPercentage: 0 })
            }));
        }
    }

    constructor() public {
        _createCandidates();
    }
}

