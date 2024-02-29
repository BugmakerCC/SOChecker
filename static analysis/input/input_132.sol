function getNftTokenHolder(address _nft, unit _tokenIds) public returns (address[]) {
    address[] memory addr = new address[](_tokenIds);
    for (uint i; i < _tokenIds; i++) {
        addr[i] = INft(_nft).ownerOf(i);
    }

}


