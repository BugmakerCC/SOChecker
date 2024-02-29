modifier mintCompliance(uint256 _mintAmount) {
    if(!presale){
      require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, "Invalid mint amount!");
      require(supply.current() + _mintAmount <= maxSupply, "Max supply exceeded!");
      _;
    }else{
      require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, "Invalid mint amount!");
      require(supply.current() + _mintAmount <= maxPresaleSupply, "Max supply exceeded!");
      _;
    }
  }

function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) {
      require(!paused, "The contract is paused!");
      require(msg.value >= cost * _mintAmount, "Insufficient funds!");

    if (msg.sender != owner()) {
        if(onlyWhitelisted == true) {
            require(isWhitelisted(msg.sender), "user is not whitelisted");
    }
    require(msg.value >= cost * _mintAmount, "insufficient funds");
    }

    _mintLoop(msg.sender, _mintAmount);
} 

function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) whenNotPaused {}

require(!paused, "The contract is paused!");


