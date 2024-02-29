require(amount <= msg.value, "pay more"); 

require(highestbid <= msg.value, "pay more");

function _setHighestBid(uint256 val) internal virtual {
  highestBid = val;
}


function _setHighestBid(uint256 val) internal override {
  highestBid = val;
  amount = val;
}


