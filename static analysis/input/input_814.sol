PoliticalParty[] public winners;
function declareWinner() public onlyOwner returns(PoliticalParty[] memory)
    {
       require(votingState == State.Canceled || block.timestamp > votingEndTime);
       if(votingState == State.Canceled){
           revert("Voting canceled.");
       }

       else{
       string memory _name="";
        uint256 max_count=0;
        
        for (uint256 i = 0; i < parties.length; i++) {
            if (parties[i].voteCount>max_count) {
                max_count = parties[i].voteCount;
                _name=parties[i].name;
                delete winners;
            winners.push(PoliticalParty({name: _name, voteCount: max_count}));
            }
            else if (max_count==parties[i].voteCount) {
                _name=parties[i].name;
                winners.push(PoliticalParty({name:_name, voteCount: max_count}));
                winnercount++;
            }
             
        }
        return winners;
       }
    }


