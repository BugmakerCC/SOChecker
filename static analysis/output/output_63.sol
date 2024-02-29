pragma solidity ^0.8.9;
interface IPriceConsumerV3 {

    
    function getLatestPrice() external view returns (int);
}

