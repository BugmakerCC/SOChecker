pragma solidity ^0.8.9;
contract ElectionV2 {
    enum ElectionState {
        ELECTION_STATE_OPEN,
        ELECTION_STATE_VOTING,
        ELECTION_STATE_CLOSED
    }

    address private election_admin;

    address[] private voters;

    uint256 public votingPeriod;

    ElectionState private election_state;


    constructor() public {
        election_admin = msg.sender;
        election_state = ElectionState.ELECTION_STATE_OPEN;
        votingPeriod = block.timestamp + 10 * 1 days;
    }

    
}

