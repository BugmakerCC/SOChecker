pragma solidity ^0.8.9;
interface IERC721 {


function approved(address, uint256 tokenId) external view returns (bool);


function getApproved(address tokenOwner, uint256 tokenId) external view returns (address operator);


function setApprovalForAll(address operator, bool approved) external virtual;


function isApprovedForAll(address owner, address operator) external view returns (bool);

}

