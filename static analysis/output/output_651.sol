pragma solidity ^0.8.9;
interface ERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed spender, uint256 indexed tokenId);
}

