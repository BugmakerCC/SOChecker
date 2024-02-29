uint256 CurrentAsk private;
uint256 CurrentBid private;
uint256 LastTransactionPrice private;

function setCurrentAsk(uint256 askPrice) public {
  CurrentAsk=askPrice
}

function setCurrentBid(uint256 bidPrice) public {
  CurrentBid=bidPrice
}

function setCurrentAsk(uint256 askPrice) public {
      require(askPrice>LastTransactionPrice,"ask higher amount")
      CurrentAsk=askPrice
    }


function setCurrentBid(uint256 bidPrice) public {
      require(bidPrice > LastTransactionPrice, "ask higher amount")
      CurrentBid=bidPrice
    }


