pragma solidity ^0.8.9;
library SafeERC1155 {
    function _transferFrom(address from, address to, uint256 tokenId) internal returns (bool) {
        return from == msg.sender && to == msg.sender;
    }
    
    function _mint(uint256 tokenId) internal returns (bool) {
        return false;
    }
    
    function _burn(uint256 tokenId) internal returns (bool) {
        return false;
    }
}

interface ERC1155 {
    function transferFrom(address owner, uint256 from, uint256 to, uint256 tokenId) external returns (bool);
    function mint(uint256 tokenId) external returns (bool);
    function burn(uint256 tokenId) external returns (bool);
    function transfer(address from, address to, uint256 tokenId) external returns (bool);
    event TransferTimestamp(uint256 tokenId, address from, address to, uint256 timestamp);
}

