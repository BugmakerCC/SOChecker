pragma solidity ^0.8.9;
contract Puisne_stakers_v1 {

    function addStaker() public payable {
        require(msg.value == 1 ether);
    }
}

