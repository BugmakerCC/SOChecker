pragma solidity ^0.8.9;
contract MyCryptoArtNFT {

  string public baseURI = "https://cryptart.io";

  uint256 _totalSupply = 420;


  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  event Transfer(address indexed from, address indexed to, uint256 indexed tokens);

  mapping(address => uint256) public tokenToAddress;

  constructor() {
    for (uint256 i = 0; i < _totalSupply; i++) {
      address wallet = msg.sender;
      tokenToAddress[wallet] = i;
      emit Transfer(address(0), wallet, i);
    }
  }
}

