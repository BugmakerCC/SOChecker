pragma solidity ^0.8.9;
interface IERC721 {

    function balanceOf(address tokenOwner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function approved(uint256 tokenId) external view returns (address owner);

    function approve(address to, uint256 tokenId) external returns (bool);

    function transferFrom(address from, address to, uint256 tokenId) external returns (bool);

    function implementsInterface(bytes4 interfaceId) external view returns (bool);

}

interface IMintOne {

    function mint(uint) external;

    function owner() external view returns (address);

    function mintedOneOf(uint index) external view returns (uint);

    function ownerOf(uint index) external view returns (address);

}

interface IMintTwo {

    function mint(uint) external;

    function owner() external view returns (address);

    function mintedTwoOf(uint index) external view returns (uint);

    function ownerOf(uint index) external view returns (address);

}

