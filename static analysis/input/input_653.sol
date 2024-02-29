pragma solidity ^0.8;

import "https:

contract MyCollection is ERC721 {
    constructor() ERC721("MyCollection", "MyC") {
        _mint(msg.sender, 1);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https:
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        string memory uri = super.tokenURI(tokenId);
        return string(abi.encodePacked(uri, ".json"));
    }
}


