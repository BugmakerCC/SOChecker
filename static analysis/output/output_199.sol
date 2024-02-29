pragma solidity ^0.8;

library TimestampHelper {
    uint constant SECONDS_PER_DAY = 24 * 60 * 60;
    uint constant SECONDS_PER_HOUR = 60 * 60;

    function getHour(uint timestamp) internal pure returns (uint hour) {
        uint secs = timestamp % SECONDS_PER_DAY;
        hour = secs / SECONDS_PER_HOUR;
    }
}

contract MyContract {
    function foo() external view {
        uint currentHour = TimestampHelper.getHour(block.timestamp);
        require(
            currentHour >= 8 && currentHour <= 18,
            "We're closed now. Opened from 8 AM to 6 PM UTC."
        );
    }
}

