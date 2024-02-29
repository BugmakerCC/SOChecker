pragma solidity ^0.8.9;
interface IPost {
  function createPost(
    string calldata title,
    string calldata text,
    string calldata image,
    uint8 category
  ) external payable;
}

interface IPost2 {
  function isCategoryExists(uint256 index) external view returns (bool);
}

