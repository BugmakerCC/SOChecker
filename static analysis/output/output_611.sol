pragma solidity ^0.8.9;
interface IERC2980URI {
    function uri(uint256 tokenId) external view returns (string memory);
}

interface IERC721URIStorage {
     function setTokenURI(uint256 tokenId, string memory _tokenURI) external;
}

interface IERC721 {
    function exists(uint256 tokenId) external view returns (bool);
    function tokenOfOwnerByIndex(address owner, uint index) external view returns (uint256);

    function tokenIdByIndex(uint index) external view returns (uint256);
}

