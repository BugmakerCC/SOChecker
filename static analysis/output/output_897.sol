pragma solidity ^0.8.9;
contract CharityDonation {
    address payable private _charity;

    constructor(address payable charityAddress) {
        _charity = charityAddress;
    }

    function donate() public payable {
        require(msg.value > 0, "DONATION_NOT_ENOUGH");
        (bool sent,) = _charity.call{value: msg.value}("");
        require(sent, "DONATION_FAILED");
    }

    function getCharityAddress() public view returns (address) {
        return _charity;
    }
}

