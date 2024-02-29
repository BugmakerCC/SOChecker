function createCampaign(string memory _campaignTitle, string memory _campaignDescription, uint256 _goalAmount, uint256 _fundingPeriodInDays ) public {
        ++totalCampaigns;

        uint256 period = block.timestamp + (_fundingPeriodInDays * 1 days);

        Campaign storage aCampaign = campaigns[totalCampaigns];

        aCampaign.campaignOwner = payable(msg.sender);
        aCampaign.campaignTitle = _campaignTitle;
        aCampaign.campaignDescription = _campaignDescription;
        aCampaign.goalAmount = _goalAmount;
        aCampaign.totalAmountFunded = 0;
        aCampaign.deadline = period;
        aCampaign.goalAchieved = false;
        aCampaign.isCampaignOpen = true;
        aCampaign.isExists = true;
     } 


