pragma solidity ^0.8.9;
contract BidContract {
    uint256 public highestBid;
    uint256 public amount;

    constructor() public {
        highestBid = 0;
        amount = 0;
    }

    function bid() public payable {
        require(amount <= msg.value, "pay more"); 
        require(highestBid <= msg.value, "pay more");

        if (msg.value > highestBid) {
            highestBid = msg.value;
        }
    }

    function _setHighestBid(uint256 val) internal virtual {
      highestBid = val;
    }

    function _setHighestBidAndAmount(uint256 val) internal {
      highestBid = val;
      amount = val;
    }
}

