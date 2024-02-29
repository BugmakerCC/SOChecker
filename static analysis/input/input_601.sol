contract ezeNFT {
    uint256 public tokenCounter;

    constructor(){
        tokenCounter = 201;
    }

    function _mintNewNFT( string memory name, string memory symbol, string memory tokenUri) public {
        uint256 newTokenId = tokenCounter;
        ezeynftFactory nfts = new ezeynftFactory(name,symbol,tokenUri,newTokenId);
        tokenCounter += 1;
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4) {

        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}

contract ezeynftFactory is ERC721 {
    constructor(string memory name, string memory symbol,string memory tokenURI,uint tokenID) 
     ERC721(name,symbol)
    {
        _mint(msg.sender, tokenID); 
        _setTokenURI(tokenID,tokenURI);
    }
}


