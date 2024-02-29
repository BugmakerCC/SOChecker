transferFrom(address(this), msg.sender,tokenId);

function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }

  address owner=ERC721.ownerOf(tokenId);
  transferFrom(owner, msg.sender,tokenId);
  


