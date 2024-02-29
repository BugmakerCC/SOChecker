pragma solidity ^0.8.9;
contract DonationContract {
    struct Donation {
        string pickupDate;
        string pickupTime;
        string availabilityDate;
        string pickupHours;
        string itemType;
        string otherItem;
        string itemDescription;
        uint quantity;
        string requiresRefrigeration;
        string bestConsumedDate;
        string partialDonation;
    }

    Donation[] public donations;

    function createDonation(
        string memory _pickupDate,
        string memory _pickupTime,
        string memory _availabilityDate,
        string memory _pickupHours,
        string memory _itemType,
        string memory _otherItem,
        string memory _itemDescription,
        uint _quantity,
        string memory _requiresRefrigeration,
        string memory _bestConsumedDate,
        string memory _partialDonation
    )
    
    public {
        Donation memory newDonation = Donation(
            _pickupDate,
            _pickupTime,
            _availabilityDate,
            _pickupHours,
            _itemType,
            _otherItem,
            _itemDescription,
            _quantity,
            _requiresRefrigeration,
            _bestConsumedDate,
            _partialDonation
        );
        donations.push(newDonation);
    }
    function getDonationCount() public view returns (uint) {
        return donations.length;
    }
}

