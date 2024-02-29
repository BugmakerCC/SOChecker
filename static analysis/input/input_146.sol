(bool success, bytes memory data) = payable(manager).call{value: fee}("");
require(sent, "transfer failed");

Reason: missing revert data in call exception; Transaction reverted without a reason string

    function withdrawDonations(
        uint256 _id
    ) public authorisedPerson(_id) returns (bool) {
        (uint256 raisedAmount, uint256 fee) = calculatePlatformFee(_id);

        require(fee <= (address(this).balance), "fee in excess of balance");

        payable(manager).transfer(fee);
        emit Action(_id, "Funds Withdrawn", msg.sender, block.timestamp);
        return true;
    }


