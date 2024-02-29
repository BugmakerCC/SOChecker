    function placeBet(Game.Teams x) external payable returns (uint256) {
        int256 _diff = getScoreDifference(x);
        return calculatePayout(msg.value, _diff);
    }


