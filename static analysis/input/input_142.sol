  uint public listingPrice=0.025 ether;

require(msg.value==listingPrice,"Price must be equal to listing fee");

function setListingPrice(uint newPrice) external onlyOwner{
    require(newPrice>0,"Price must be at least 1 wei");
    listingPrice=newPrice;
  }


