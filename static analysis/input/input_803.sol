constructor() public {
  _name = {{TOKEN_NAME}};
  _symbol = {{TOKEN_SYMBOL}};
  _decimals = {{DECIMALS}};
  _totalSupply = {{TOTAL_SUPPLY}};
  _balances[msg.sender] = _totalSupply;

  emit Transfer(address(0), msg.sender, _totalSupply);
}

constructor() public {
  _name = "MyToken";
  _symbol = "MyT";
  _decimals = 18;
  _totalSupply = 1000000000000000000;
  _balances[msg.sender] = _totalSupply;

  emit Transfer(address(0), msg.sender, _totalSupply);
}


