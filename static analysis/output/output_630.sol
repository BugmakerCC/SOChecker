pragma solidity ^0.8.9;
abstract contract ERC721 {
    bytes4 public constant interfaceERC721 = 0x20095833;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    function balanceOf(address owner) external view virtual returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view virtual returns (address owner);
    function transferFrom(address from, address to, uint256 tokenId) external virtual;
    function approve(address to, uint256 tokenId) external virtual;
    function getApproved(uint256 tokenId) external view virtual returns (address owner);
    
    
    function _transfer(address from, address to, uint256 tokenId) internal virtual;
    function _owners(uint256 tokenId) internal view virtual returns (address owner);
    function _setApprovalForAll(address owner, address operator, bool approved) internal virtual;
}

