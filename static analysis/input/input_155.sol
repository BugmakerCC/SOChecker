function getOwnerByIndex(uint index) public view returns (uint256) {

    return tokenOfOwnerByIndex(address(msg.sender), index);
}

function getOwnerByIndex(uint256 index) public view returns (address) {
    uint256 tokenId = tokenByIndex(index);
    address owner = ownerOf(tokenId);
    return owner;
}


