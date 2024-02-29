contract ERC20FixedSupply is ERC20 {
  constructor() ERC20("Fixed", "FIX") {
      _mint(msg.sender, 1000);
  }
}


