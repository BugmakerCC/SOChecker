 Listing[] storage userItems = userListings[msg.sender]

for(uint256 i=0; i<userItems.length; i++){

   if userItems[i].listingId==listingId{
      userItems[i].status=ListingStatus.Cancelled,
}


