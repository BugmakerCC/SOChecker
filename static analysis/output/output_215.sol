pragma solidity ^0.8.9;
contract Auction {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct Campaign {
        uint256 campaignID;
        uint256 budget;
        uint256 bidCount;
        mapping(uint => Bidder[]) bidders;
    }

    struct Bidder {
        bool bided;
        uint256 bid;
        string name;
        address bidderAddress;
    }

    Campaign[] public campaigns;
    uint totalCampaign = 0;

    modifier onlyOwner {
        require(msg.sender == owner, "Error! You're not the smart contract owner!");
        _;
    }

    function createCampaing(uint _budgetCampaign) public onlyOwner {
        Campaign storage _firstCampaigns = campaigns.push();
        _firstCampaigns.campaignID = totalCampaign;
        _firstCampaigns.budget = _budgetCampaign;
        totalCampaign++;
    }

    function bid(uint _indexCampaign, string memory _nameBidder) public {
        Campaign storage _bidCampaign = campaigns[_indexCampaign];
        _bidCampaign.bidCount += 1;
        uint _bidIndex = _bidCampaign.bidCount;
        _bidCampaign.bidders[_indexCampaign].push(Bidder(true, _bidIndex, _nameBidder, msg.sender));
    }

    function getBids(uint _indexCampaign) onlyOwner external view returns(Bidder[] memory) {
        return campaigns[_indexCampaign].bidders[_indexCampaign];
    }
}

