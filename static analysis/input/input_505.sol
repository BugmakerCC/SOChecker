pragma solidity ^0.8;

contract MyContract {
    address payable[] public bidders;
    mapping (address => bool) isBidder; 

    function placeBid() public {
        if (isBidder[msg.sender] == false) {
            bidders.push(payable(msg.sender));
            isBidder[msg.sender] = true;
        }
    }
}


