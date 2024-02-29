pragma solidity ^0.8.9;
interface IMyNFT {
  function mintNFT(address to, string calldata uri) external;
}

