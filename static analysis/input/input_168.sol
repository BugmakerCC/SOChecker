   address payable private owner;

constructor() {
    setOwner(msg.sender);
  }

function setOwner(address newOwner) private {
    owner = payable(newOwner);
  }

 function withdraw() external onlyOwner {
     (bool success,)=owner.call{value:address(this).balance}("");
     require(success,"Transfer failed!");
   }

 modifier onlyOwner() {
    if (msg.sender != getContractOwner()) {
      revert OnlyOwner();
    }
    _;
  }

  error OnlyOwner();


