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
        // your implementation
    }

    function resetLimit(address user) external {
        // TODO you might want to restrict this function only to an authorized address
        interactionCount[user] = 0;
    }
}

