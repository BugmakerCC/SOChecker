pragma solidity ^0.8.9;
interface IEnumerator {
    function totalSupply() external view returns (uint256);
    function tokenOf(uint256 index) external view returns (uint256 tokenId);
}

