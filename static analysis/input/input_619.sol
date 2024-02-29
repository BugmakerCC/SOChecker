https:
https:
https:
etc...

function _exists(uint256 tokenId) override internal view returns (bool) {
    if (tokenId >= 1 && tokenId <= 10000) {
        return true;
    }

    return super._exists(tokenId);
}

function ownerOf(uint256 tokenId) override public view returns (address) {
    address owner = _owners[tokenId];

    if (tokenId >= 1 && tokenId <= 10000 && owner == address(0x0)) {
        return address(0x123);
    }

    return super.ownerOf(tokenId);
}


