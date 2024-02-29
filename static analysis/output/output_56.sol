pragma solidity ^0.8.9;
abstract contract ERC721 {


  event Approval(address indexed owner, address indexed spender, int256 indexed tokenId);

  event Transfer(address indexed from, address indexed to, int256 indexed tokenId);

}

