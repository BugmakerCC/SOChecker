pragma solidity ^0.8.9;
interface IERC1155 {
    function getPendingRewards(address owner, uint256 fuelId) external view returns (uint256) ;
}

interface Fuel {
    function ownerOf(uint256 fuelId) external view returns (address);
}

interface Energy {
    function mintRewards(address, uint256) external;
}

interface IERC721 {
    event Received(address indexed from, address indexed to, uint256 value);

    function onERC721Received(address from, address to, uint256 value) external virtual returns (bytes4);
}

