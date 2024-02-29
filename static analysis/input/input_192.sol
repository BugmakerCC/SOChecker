function getScoreDifference (Game.Teams x) public view returns (int256) {
  if (x == Game.Teams.Team1) {
    return game.team1Score - game.team2Score;
  } else if (x == Game.Teams.Team2) {
    return game.team2Score - game.team1Score;
  }
}

function getScoreDifference (Game.Teams x) public view returns (int256 score) {
  if (x == Game.Teams.Team1) {
    return score = game.team1Score() - game.team2Score();
  } else if (x == Game.Teams.Team2) {
    return score = game.team2Score() - game.team1Score();
  }
}


