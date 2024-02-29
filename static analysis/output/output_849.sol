pragma solidity ^0.8.9;
contract Pausable {
    address public owner;
    bool public paused = false;

    constructor() public {
        owner = msg.sender;
    }

    modifier restricted() {
        require(paused == false || msg.sender == owner, "Token is paused");
        _;
    }
    
    function pause() external restricted {
        paused = true;
    }
    
    function unpause() external restricted {
        paused = false;
    }
}

