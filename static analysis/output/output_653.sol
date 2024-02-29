pragma solidity ^0.8.9;
interface IERC721 {
    function mint(address to, uint256 tokenId) external;

    function mintBatch(address to, uint256[] calldata tokenIds) external;

    function burn(uint256 tokenId) external;

    function burnBatch(uint256[] calldata tokenIds) external;
}

interface IERC1155 {
    function mint(address to, uint256 tokenId) external;

    function mintBatch(address to, uint256[] calldata tokenIds) external;

    function burn(uint256 tokenId) external;

    function burnBatch(uint256[] calldata tokenIds) external;
}

