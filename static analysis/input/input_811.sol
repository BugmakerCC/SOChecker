    function getPayout(address payable addressOfProposer)
        public
        returns (bool)
    {
        uint256 allowanceAvailable = _payoutTotals[addressOfProposer];
        require(allowanceAvailable > 0, "You do not have any funds available.");

        _decreasePayout(addressOfProposer, allowanceAvailable);

        (bool sent, ) = addressOfProposer.call{value: allowanceAvailable}("");
        require(sent, "Failed to send ether");

        emit Withdraw(addressOfProposer, allowanceAvailable);
        return true;
    }


