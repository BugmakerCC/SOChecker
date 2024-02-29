
pragma solidity >=0.7.0 <0.9.0;

contract Auction {
address payable internal auction_owner; 
uint256 public auction_start; 
uint256 public auction_end; 
uint256 public highestBid;
address public highestBidder;

enum auction_state {
CANCELLED, STARTED,ENDED
}
address[] bidders;

mapping(address => uint) public bids; 

auction_state public STATE;



modifier an_ongoing_auction() { require(block.timestamp <= auction_end);
_;
}

modifier only_owner() { require(msg.sender == auction_owner);
_;
}

function MyAuction (uint _biddingTime, address payable  _owner) public {
     auction_owner = _owner; 
     auction_start = block.timestamp;
    auction_end = auction_start + _biddingTime* 1 minutes;
     STATE = auction_state.STARTED;
    if (block.timestamp>auction_end){
        STATE=auction_state.ENDED;
        auction_owner.transfer(highestBid);
        bids[highestBidder]=0;
        
    } 

}

function bid() public payable an_ongoing_auction returns (bool){ 

    require(bids[msg.sender] + msg.value > highestBid, "can't bid, Make a higher Bid" );

    highestBidder = msg.sender; 
    highestBid = msg.value; 
    bidders.push(msg.sender);
    bids[msg.sender] = bids[msg.sender] + msg.value; 
    emit BidEvent(highestBidder, highestBid);
    return true; 
    }

    
function withdraw() public payable returns (bool){
    require(block.timestamp > auction_end , "can't withdraw, Auction is still open");
    uint amount= bids[msg.sender];
    bids[msg.sender] = 0; 
    payable(msg.sender).transfer(amount); 
    emit WithdrawalEvent(msg.sender, amount);
    return true;
}
function cancel_auction() only_owner an_ongoing_auction public returns (bool) {
     STATE = auction_state.CANCELLED;
    emit CanceledEvent("Auction Cancelled", block.timestamp,highestBid); 
    return true;
}
function time_remain() an_ongoing_auction public view returns (uint256){
uint256 timeleft= auction_end - block.timestamp;
return timeleft; 

}

event BidEvent(address highestBidder, uint256 highestBid); 

event WithdrawalEvent(address withdrawer, uint256 amount);

event CanceledEvent(string message, uint256 time, uint256 highestBid);
    
}



