pragma solidity ^0.8.9;
interface IERC4907 {
    function setUser(uint256 tokenId, address user, uint64 expires) external payable;
}

