pragma solidity ^0.8.9;
interface IERC1155 {
    function _exists(uint256 tokenId) external view returns (bool);

    function ownerOf(uint256 tokenId) external view returns (address);
}

