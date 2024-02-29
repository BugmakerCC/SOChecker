pragma solidity ^0.8.9;
contract TrainingResults {
    
    enum Stage {
        NONE,
        STAGE_1,
        STAGE_2,
        COMPLETED
    }
    
    mapping (address => Stage) public participantStage;
    
    function setParticipantStage(address _graduate, Stage _stage) external {
        require(msg.sender == address(0x123), "Not authorized");
        participantStage[_graduate] = _stage;
    }
}

