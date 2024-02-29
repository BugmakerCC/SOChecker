pragma solidity ^0.8.9;
interface ERC721 {

    event Transfer(address indexed from, address indexed to, bytes32 indexed tokenId, uint256 value);

    event Approval(address indexed owner, address indexed spender, bytes32 indexed tokenId);

    function balanceOf(address owner) external view returns (uint256 balance);

    function safeTransferFrom(address from, address to, uint256 tokenId, uint256 value, bytes memory data) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address spender, uint256 tokenId) external;

    function getApproved(bytes32 tokenId) external view returns (address);

    function setApprovalForAll(address operator, uint256 tokenId, uint256 value) external;
}

