pragma solidity ^0.8.9;
interface IERC20 {
    function mint(address to, uint256 tokenId, uint256 amount)
        external

        returns (uint256);
    function burn(uint256 tokenId) external;

    function mint(address to, uint256 tokenId, uint256 amount, bytes memory data)
        external
        returns (uint256);

    function burn(uint256 tokenId, bytes memory data) external returns (bytes memory);

    function getMinter(uint256 tokenId) external view returns (address);

    function setMinter(uint256 tokenId, address mint) external;

    function getMintData(uint256 tokenId) external view returns (bytes memory);

    function setMintData(uint256 tokenId, bytes memory data) external;

    function transfer(address to, uint256 tokenId, uint256 amount) external returns (bool);

    function transferFrom(address from, address to, uint256 tokenId, uint256 amount)
        external

        returns (bool);

    function approve(address to, uint256 tokenId, uint256 amount) external returns (bool);

    function setApprovalForAll(address owner, address operator, bool approved)
        external

        returns (bool);
}

