pragma solidity ^0.8.9;
contract MockNFT {
    
  event ReceivedNFT(address recipient);

  struct NFT {
    uint256 id;
    address owner;
  }

  mapping (address => mapping (uint256 => NFT)) public nfts;

  function mint(address recipient) external {
    emit ReceivedNFT(recipient);
  }

}

