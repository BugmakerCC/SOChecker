struct NFT {
    string contractAddress;
    uint256 tokenID;
    string tokenStandard;
    string blockChain;
    uint256 creatorFees;
}

NFT nftOne = NFT("0xD9D24a4b8A58BCdBfDDd0d27B51F27", 345,"ERC-721", "ETHEREUM", 721);
NFT nftTwo = NFT("0xD9824a4b8A5u8CdBfDDd0d27B51F27", 346,"ERC-721", "ETHEREUM", 721);
NFT nftThree = NFT("0xD9DE9824a4b8A58BCdBfDDd0Y1F27", 347,"ERC-721", "ETHEREUM", 721);

NFT[] nftArray;

constructor() {
    nftArray.push(nftOne);
}


