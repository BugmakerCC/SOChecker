pragma solidity ^0.8.9;
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function getApproved(address spender) external view returns ( uint256 );
    function balanceOf(address who) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
}

