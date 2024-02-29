pragma solidity ^0.8;

import "https:

contract Auction is ERC721 {
    
    constructor() ERC721("CollectionName", "Symbol") {}
    
    function createAuction() public {
        uint256 newTokenId = 1;

        _mint(msg.sender, newTokenId);
        _approve(address(this), newTokenId);
    }
    
}


