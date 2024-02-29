contract YourContract is Ownable {

uint256 public maxAmount = 10;
uint256 public price = 10 ether;

function mint(address _to, uint256 _mintAmount) public payable {
    require(_mintAmount > 0); 
    require(_mintAmount <= maxAmount);
   
    if (msg.sender != owner()) {       
          require(msg.value >= price * _mintAmount);     
    }
    
    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(_to, i);
    }
  }
}

 function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }


