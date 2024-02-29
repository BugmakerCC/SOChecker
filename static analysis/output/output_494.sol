pragma solidity ^0.8.9;
contract YourContract {
    
    address payable public userAddress;

    function subscribe(uint planId) 
        external payable 
        returns (bool) {

        require(msg.value == 1 ether, "You need to send 1 ETH");
        require(msg.sender == userAddress, "");

        emit SubscriptionSuccess(userAddress, planId);

    }

    event SubscriptionSuccess(
        address payable indexed userAddress,
        uint256 planId
    );
}

