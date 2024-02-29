pragma solidity ^0.8.9;
contract DonationCampaign {
    // Define a new structure Campaign
    struct Campaign {
        uint256 donations;
        uint256[] donationAmounts;
    }

    // Declare a state variable campaign of type Campaign
    Campaign public campaign;

    // Initialize the campaign in the constructor
    constructor() {
        campaign = Campaign(0, new uint256[](0));
    }

    // Function to donate an amount to the campaign
    function donate(uint256 amount) public {
        // Increase the total donations by the donated amount
        campaign.donations += amount;

        // Add the donated amount to the donationAmounts array
        campaign.donationAmounts.push(amount);
    }

    // Function to get the total donations
    function getTotalDonations() public view returns (uint256) {
        return campaign.donations;
    }

    // Function to get all individual donations
    function getIndividualDonations() public view returns (uint256[] memory) {
        return campaign.donationAmounts;
    }
}

