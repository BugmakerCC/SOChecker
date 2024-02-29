pragma solidity ^0.8.9;
interface IERC1155 {
  function safeMint(address to, uint256 tokenId) external;
  function safeMint(address to, uint256 tokenId, uint256 tokenURI) external;
}

contract NFTS {
  uint256 public tokenCounter;
  mapping(uint256 => string) public tokenURIs;
  mapping(uint256 => uint256) public itemIds;

  function createCollectible(string memory tokenURI) public returns(uint256) {
    require(tokenCounter == 0, "error msg here");
    uint256 newItemId = tokenCounter;
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, tokenURI);
    tokenCounter = tokenCounter + 1;
    return newItemId;
  }

  function _setTokenURI(uint256 itemId, string memory tokenURI) internal {
    itemIds[itemId] = tokenCounter;
    tokenURIs[itemId] = tokenURI;
  }

  function _safeMint(address to, uint256 tokenId) internal {
    IERC1155(address(0)).safeMint(to, tokenId);
  }
}

