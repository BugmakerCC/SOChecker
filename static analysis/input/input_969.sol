 mapping(string=>bool) private _usedTokenURIs;

function tokenURIExists(string memory tokenURI) public view returns(bool){
    return _usedTokenURIs[tokenURI]==true;
  }

  require(!tokenURIExists(tokenURI),"Token URI already exists")


