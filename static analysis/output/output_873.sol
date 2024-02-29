pragma solidity ^0.8.9;
abstract contract Abstract {
    uint256 private lastTimeStamp;
    uint256 private interval;

    constructor() {
        lastTimeStamp = block.timestamp;
        interval = 7 days;
    }

    function isTimePassed() public view returns (bool timePassed) {
        timePassed = (
            (block.timestamp - lastTimeStamp) > 
            interval
        );
        return timePassed;
    }

    modifier isAllowedTimePassed() {
        require(isTimePassed(), "Allowed only once per interval.");
        _;
    }
}

