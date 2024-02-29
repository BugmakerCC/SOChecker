pragma solidity ^0.4.25;
contract ERC721 {
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}

