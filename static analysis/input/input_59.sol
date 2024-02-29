pragma solidity ^0.8;

contract MyContract {
    address payable[] public participants;

    function foo() public {
        uint amount = 1; 
        for (uint i = 0; i < participants.length; i++) {
            participants[i].transfer(amount);
        }
    }
}


