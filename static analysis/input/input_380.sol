contract YourToken is ERC721 {
  ERC20 private immutable token;

  constructor(ERC20 t) {
    token = t;
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) public payable {
    token.transferFrom(_from, _to, 10);
  }
}


