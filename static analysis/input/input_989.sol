 function changeVote() public checkSender(msg.sender){
        olderVoter = caller;
    }

function changeVote() public checkSender(msg.sender){
        require(oldVoter != actualVoter); 
        olderVoter = caller;
    }


