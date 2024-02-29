pragma solidity ^0.8.9;
interface IPriceFeed {
    function latestRoundData() external view returns (uint256, int256, uint256, uint256, uint256);
}

contract MyPriceFeed {
    IPriceFeed public priceFeed;
    
    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 10000000000);
    }
    
    constructor(address priceFeedAddress) {
        priceFeed = IPriceFeed(priceFeedAddress);
    }
}

