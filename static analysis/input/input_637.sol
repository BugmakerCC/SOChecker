function buyTokens(uint256 amount) external {
  _mint(msg.sender, (98 * amount)/100);
  _mint(liquidityPoolOwnerAddress, amount/100);
  _mint(liquidityPoolAddress, amount/100);
}



