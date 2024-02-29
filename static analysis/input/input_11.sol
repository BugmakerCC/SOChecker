function createCollectible(string memory tokenURI) public returns(uint256) {
    require(tokenCounter == 0, "error msg here");
    uint256 newItemId = tokenCounter;
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, tokenURI);
    tokenCounter = tokenCounter + 1;
    return newItemId;
  }


