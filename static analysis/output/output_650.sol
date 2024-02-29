pragma solidity ^0.8.9;
contract BettingGame {
    enum Teams {
        Team1,
        Team2
    }

    struct Game {
        Teams team;
        uint256 score1;
        uint256 score2;
    }

    Game public game;

    function placeBet(Teams x) external payable returns (uint256) {
        int256 _diff = getScoreDifference(x);
        return calculatePayout(msg.value, _diff);
    }

    function getScoreDifference(Teams x) public view returns (int256) {
        if (x == Teams.Team1) {
            return int256(game.score1) - int256(game.score2);
        } else {
            return int256(game.score2) - int256(game.score1);
        }
    }

    function calculatePayout(uint256 _value, int256 _diff) public pure returns(uint256) {
        return _value + uint256(_diff > 0 ? _diff : -_diff);
    }
}

