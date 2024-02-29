contract NFT is ERC721URIStorage { }

function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }

function _baseURI() internal view virtual returns (string memory) {
        return "";
    }

 contract NFT is ERC721{
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
       require(_exists(tokenId), "...");
       _tokenURIs[tokenId] = _tokenURI;
           }
   }


