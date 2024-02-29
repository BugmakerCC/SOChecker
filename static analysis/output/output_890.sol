pragma solidity ^0.8.9;
contract IncrementalPriceContract {
    struct IncrementalPrice {
        uint value;
        uint price;
    }
    
    IncrementalPrice[] public prices;
    
    function setData() public {
        prices.push(IncrementalPrice(0, 1000));
        prices.push(IncrementalPrice(0.01 ether, 2000));
        prices.push(IncrementalPrice(0.01 ether, 2000));
    }
}

