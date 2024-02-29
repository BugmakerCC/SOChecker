struct Game {
    address host; 
    uint gameId; 
    uint buyinRequirement; 
    uint etherWithdrawalReqs; 
    uint gamePot; 
    uint8 tableWithdrawalReqs; 
    uint8 playerCount; 
    uint8 verifiedWithdrawalReqs; 
    bool endedBuyin; 
    bool isActive; 
    address[] playerList; 
}

function startGame(string memory name, uint buyinReq) public payable isNotInGame {     
    require(initFee == .001 ether, "In order to prevent spam games that never resolve, each game initialization will cost  ether.");
    addFeesPending();
    playerInfo[msg.sender] = Player(name, gameNumber, 0, 0, false, false, false, false, true);
    address[] memory add;
    idToGame[gameNumber] = Game(msg.sender, gameNumber, buyinReq, 0, 0, 0, 0, 0, false, true, add);
    idToGame[gameNumber].playerList.push(msg.sender);
    games.push(idToGame[gameNumber]);
    incGameNumber();
}    

function getGameInfo(uint id) public view returns (Game memory) {
    return idToGame[id];
}


