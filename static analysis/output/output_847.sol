pragma solidity ^0.4.19;
contract Elector {

    struct Vote {
        bytes32 hashedQuestion;
        bytes32 hashedProposal;
        bool vote;
        VoteType voteType;
    }

    struct VoteType {
        bool yes;
        bool no;
    }

    function vote(
        bytes32 hashedQuestion,
        bytes32 hashedProposal,
        bytes32 voteTypeHash,
        address voterAddress
    ) external returns (bool);

    function getQuestion(
    ) external returns (bytes memory question);

    function getProposals(
        bytes32 questionHash
    ) external returns (bytes memory proposals);

    function getInformation() external view returns (address, VoteType);
}

