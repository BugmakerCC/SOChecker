pragma solidity ^0.4.25;
contract EtheriumMint {

   
  bool public isPublicMintEnabled = false;

  function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner {
    isPublicMintEnabled = isPublicMintEnabled_;
  }

  modifier onlyOwner() {
    require(msg.sender == address(0x60839411756371021472764702672698431903879), "Ownable: Caller is not the owner");
    _;
  }

  constructor() public {
    isPublicMintEnabled = true;
  }

}

