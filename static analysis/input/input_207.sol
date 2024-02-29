function transferNFTtoNewOwner(NFTItem memory t,address oldOwner, address newOwner) internal {
    require(newOwner != address(0), "New owner can't be address zero.");
    XXXX storage r = creatureList[t.tokenAddress][t.tokenId];
    IERC721 nft = IERC721(t.tokenAddress);
    nft.safeTransferFrom(oldOwner, newOwner, t.tokenId); 
    address currOwner = nft.ownerOf(t.tokenId);
    require(newOwner == currOwner, "Problem on nft transfer");
    r.owner = newOwner; 
}


