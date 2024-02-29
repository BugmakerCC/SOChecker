pragma solidity ^0.8.9;
interface IERC721 {
    
    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address);

    function setApprovalForAll(address operator, bool approved) external;

}

