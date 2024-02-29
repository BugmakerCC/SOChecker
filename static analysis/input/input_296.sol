function GetBetTitle(address betAddress) public view returns(string){
       BetContract currentBet = BetContract(payable(betAddress));

       return currentBet.GetTitle();
   }


