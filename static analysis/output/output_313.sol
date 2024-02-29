pragma solidity ^0.8.9;
interface IERC721Receiver {
     function onERC721Received(address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

interface ERC721Burnable {
   
    function burn(address owner, uint256 tokenId) external;
}

