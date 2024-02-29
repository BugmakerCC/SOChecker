ParserError: Function, variable, struct or modifier declaration expected.
  --> stable coin lil.sol:54:1:
   |
54 | 
   | ^

function marketing(uint256 amount) public onlyOwner {
  uint256 marketingTaxAmount = amount.mul(MARKETING_TAX).div(100);

  _transfer(address(this), _msgSender(), marketingTaxAmount);
} 


