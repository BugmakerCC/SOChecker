IERC721 public nftOne;
uint public nftTwoMaxMintCount;
mapping(uint => uint) public nftTwoMints;

function mintNftTwo(uint nftOneTokenId) external {

    require(msg.sender == nftOne.ownerOf(nftOneTokenId), "not the owner of nftOne token");

    require(nftTwoMints[nftOneTokenId] <= nftTwoMaxMintCount, "nftTwo token mints overflow");

    nftTwoMints[nftOneTokenId] += 1;

    _mintNftTwo(); 

}


