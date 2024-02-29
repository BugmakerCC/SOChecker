pragma solidity ^0.8.9;
contract Game {
  struct Game {
    Teams team1Score;
    Teams team2Score;
  }

  struct Teams {
    int256 score;
  }
}

