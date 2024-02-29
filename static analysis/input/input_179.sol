function setUser(uint256 tokenId, address user, uint64 expires) public virtual override(IERC4907){
    if (_exists(tokenId) == false) {
        _mint(msg.sender, tokenId); 
    }

    require(_isApprovedOrOwner(msg.sender, tokenId), "ERC4907: transfer caller is not owner nor approved");
    UserInfo storage info =  _users[tokenId];
    info.user = user;
    info.expires = expires;
    emit UpdateUser(tokenId, user, expires);
}


