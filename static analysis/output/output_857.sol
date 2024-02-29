pragma solidity ^0.8.9;
interface KeeperCompatibleInterface {
    function setTokenName(uint256 tokenId, string calldata tokenName) external;
}

