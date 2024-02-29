pragma solidity >=0.7.0 <0.9.0;

contract EightFoundingFathers is ERC721A, Ownable, ReentrancyGuard {

  string public        baseURI;
  uint public          price             = 0.003 ether;
  uint public          maxPerTx          = 20;
  uint public          totalFree         = 1000;
  uint public          maxSupply         = 1776;
  uint256 public       maxFreePerWallet = 3;
  bool public          mintEnabled;
  mapping(address => uint256) private _mintedFreeAmount;

  constructor() ERC721A("8Bit Founding Fathers","8BFF"){

  }
}


