function changeAuctionEndTime(uint extraTimeAmount) public {
    require(msg.sender == contractOwner, "ONLY THE CONTRACT's OWNER CAN CALL THIS FUNCTION!");  
    auctionEndTime += extraTimeAmount * 1 minutes;  
}



