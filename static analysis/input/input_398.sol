function issue(uint amount) public onlyOwner {
    require(_totalSupply + amount > _totalSupply);
    require(balances[owner] + amount > balances[owner]);

    balances[owner] += amount;
    _totalSupply += amount;
    Issue(amount);
}


