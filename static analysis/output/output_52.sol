pragma solidity ^0.8.9;
    interface ERC721 {
        event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
        function approve(address to, uint256 tokenId) external;
        function getApproved(uint256 tokenId) external view returns (address);
        function getOwner(uint256 tokenId) external view returns (address);
        function transferFrom(address from, address to, uint256 tokenId) external;
        event Approval(address indexed owner, address indexed spender, uint256 tokenId);
    }

