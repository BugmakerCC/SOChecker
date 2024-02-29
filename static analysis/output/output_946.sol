pragma solidity ^0.8.9;
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
    function approve(address spender, uint256 tokenId) external returns (bool);
    function transferFrom(address from, address to, uint256 tokenId) external returns (bool);
    function transfer(address recipient, uint256 tokenId) external returns (bool);
}

