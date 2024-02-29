function _transfer(address sender, address recipient, uint256 amount) private {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(balanceOf(sender) >= amount, "BEP2': not enough balance");
    
    uint256 tokensToBurn = amount.mul(burningFee).div(100);
    amount = amount.sub(tokensToBurn);

    balances[sender] = balances[sender].sub(amount);

    _burn(sender, tokensToBurn);
    balances[recipient] = balances[recipient].add(amount);
    
}


