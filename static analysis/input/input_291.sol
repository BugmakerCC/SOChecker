function getPower() public {
    require(election_state == ELECTION_STATE.OPEN);
    require(votingPeriod > block.timestamp);
    voters[msg.sender].power = msg.sender.balance * 10;
}


