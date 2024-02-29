pragma solidity ^0.8;

contract MyContract {
    address payable[] public bidders;
    mapping (address => bool) isBidder; // default `false`

    // only add `msg.sender` to `bidders` if it's not there yet
    function placeBid() public {
        // check against the mapping
        if (isBidder[msg.sender] == false) {
            // push the unique item to the array
            bidders.push(payable(msg.sender));
            // don't forget to set the mapping value as well
            isBidder[msg.sender] = true;
        }
    }
}

