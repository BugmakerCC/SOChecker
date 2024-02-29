pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    
    constructor() {
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

    
    function getLatestPrice() public view returns (int) {
        (
,
            int price,
,
,
        ) = priceFeed.latestRoundData();
        return price;
    }
}


