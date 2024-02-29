function withdraw(uint256 _id) public {
  Campaign storage campaign = campaigns[_id];

  (bool success, ) = payable(campaign.owner).call{value: campaign.amountCollected}("");
  require(success, "Withdrawal failure");
  campaign.amountCollected = 0;
}


