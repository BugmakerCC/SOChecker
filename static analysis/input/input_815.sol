constructor(address[] _teammates)
    for(uint256 i = 0; i < _teammates.length; i++){
        _mint(_teammates[i], i); 
    }
}

constructor(address[] _teammates)
    teammates = _teammates;
}

function distributeTokensToTeam() public onlyOwner{
    for(uint256 i = 0; i < teammates.length; i++){
        transfer(teammates[i], i); 
    }
}


