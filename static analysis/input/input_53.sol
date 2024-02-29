ERC721(nftAddress).safeTransferFrom(msg.sender, address(this), tokenID);

return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);


    
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view virtual override returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ERC721.ownerOf(tokenId);
        console.log("spender %s", spender);
        console.log("getApproved %s", getApproved(tokenId);
        return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);
    }


