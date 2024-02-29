address contractDeployer;
uint txCharge = 1 

constructor(string memory name_, string memory symbol_) {
  _name = name_;
  _symbol = symbol_;
  contractDeployer= msg.sender;
}

function transfer(address to, uint256 amount) public virtual override returns (bool) {
  address owner = _msgSender();
  _transfer(owner, contractDeployer, amount * txCharge / 100); 
  _transfer(owner, to, amount - (amount * txCharge/100);
  return true;
}


