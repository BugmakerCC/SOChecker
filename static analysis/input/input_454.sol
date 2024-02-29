ERC20 public token;

AggregatorV3Interface internal priceFeed; 

function registerAsset(string memory description, uint256 price, uint256 shares) external onlyOwner {
    require(shares > 0, "Shares must be greater than 0.");
    assetCount++;
    assets[assetCount] = Asset(msg.sender, description, price, shares);
}


