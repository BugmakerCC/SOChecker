pragma solidity ^0.8.9;
contract AssetRegistry {
    address public owner;
    uint256 public assetCount = 0;

    struct Asset {
        address owner;
        string description;
        uint256 pricePerShare;
        uint256 shares;
    }

    mapping(uint256 => Asset) public assets;

    event RegisterAsset(
        string description,
        uint256 price,
        uint256 shares
    );

    event SetAssetPrice(
        uint256 assetId,
        uint256 newPrice
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function registerAsset(
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

