pragma solidity ^0.8.9;
interface IERC721 {
    event Approval(address indexed owner, address indexed approved, uint256 tokenId);
    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address);
    function setApprovalForAll(address operator, bool isApproved) external;
}

