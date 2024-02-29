pragma solidity ^0.4.25;
contract AuctionEndTimeExtension {
    
    address public contractOwner;
    
    uint public auctionEndTime = 431111394;
    
    function changeAuctionEndTime(uint extraTimeAmount) public {
        require(msg.sender == contractOwner, "ONLY THE CONTRACT's OWNER CAN CALL THIS FUNCTION!");  
        auctionEndTime += extraTimeAmount * 1 minutes;  
    }
    
    function() external payable {
    }
    
    constructor() public {
        contractOwner = msg.sender;
    }
}

