pragma solidity ^0.8;

contract MyContract {
    uint256 constant MAX_INTERACTIONS = 10;
    mapping(address => uint256) interactionCount;

    modifier limit {
        require(interactionCount[msg.sender] < MAX_INTERACTIONS);
        interactionCount[msg.sender]++;
        _;
    }

    function foo() external limit {
    }

    function resetLimit(address user) external {
        interactionCount[user] = 0;
    }
}


