pragma solidity ^0.8.9;
abstract contract ERC721 {

    function tokenOfOwnerByIndex(address owner, uint index) public virtual view returns (uint256 tokenId);

    function ownerOf(uint256 tokenId) public view virtual returns (address owner);

    function tokenByIndex(uint index) public view virtual returns (uint256);
}

