pragma solidity ^0.8.9;
contract Voting {
    address public olderVoter;
    address public oldVoter;
    address public actualVoter;
    
    modifier checkSender(address _sender) {
        require(_sender == msg.sender, "Only the contract creator can call this.");
        _;
    }

    function changeVote() public checkSender(msg.sender){
        olderVoter = msg.sender;
    }

    function updateVote() public checkSender(msg.sender){
        require(oldVoter != actualVoter, "The old voter cannot be the actual voter."); 
        olderVoter = msg.sender;
    }

    constructor() public {
        actualVoter = msg.sender; 
    }
}

