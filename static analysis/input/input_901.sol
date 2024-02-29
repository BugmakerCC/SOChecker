contract LotteryContract {
  function buyTicket() public {
  }
}

contract CasinoContract {
  function placeBet() public {
    LotteryContract.buyTicket()
  }
}


