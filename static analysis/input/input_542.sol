function vote(uint _entrociterID) public {
    require(votes[msg.sender] <MAX_VOTES_PER_VOTER, "Voter has no votes left."); 
    require(_entrociterID > 0 && _entrociterID <= entrociterCount, " Entrociter ID is out of range.");

    votes[msg.sender]++; 
    Entrociter storage entrociter=entrociters[_entrociterID]; 
    entrociter.votes++;
    entrociters[entrociterCount] = entrociter;
    emit Voted(); }

    function addEntrociter(string memory _name, string memory _party) public {
    entrociterCount++;

    Entrociter memory entrociter = Entrociter(entrociterCount, _name, _party, 0);
    entrociters[entrociterCount] = entrociter;

    emit NewEntrociter();
 }


