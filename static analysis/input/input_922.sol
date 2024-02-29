   function getEntranceFee() public view returns (uint256) {
        uint256 minimumUSD = 50 * (10**18);
        uint256 price = getPrice();
        uint256 pricision = 1 * (10**18);
        return ((minimumUSD * pricision) / price);
    }


