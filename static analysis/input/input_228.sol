function registerAsset(
    external function
        string memory description,
        uint256 price,
        uint256 shares
    ) external onlyOwner {
        require(shares > 0, "Shares must be greater than 0.");
        assetCount++;
        assets[assetCount] = Asset(msg.sender, description, price, shares);
        emit RegisterAsset(description, price, shares);
    }

function setAssetPrice(
        uint256 assetId,
        uint256 newPrice
    ) external onlyOwner {
        require(assetId > 0 && assetId <= assetCount, "Invalid asset ID.");
        Asset storage asset = assets[assetId];
        require(asset.owner != address(0), "Asset does not exist.");
        asset.pricePerShare = newPrice;

        emit SetAssetPrice(assetId, newPrice);
    }
}


