pragma solidity 0.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MyContract {
    AggregatorV3Interface priceFeed;
    uint256 requiredPriceInUsd = 1000 * 1e18;

    constructor() {
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    function getRequiredPriceInWei() public view returns (uint256) {
        (,int answer,,,) = priceFeed.latestRoundData();

        uint256 ethUsdPrice = uint256(answer) * 1e10;

        return (requiredPriceInUsd * 1e18) / ethUsdPrice;
    }
}


