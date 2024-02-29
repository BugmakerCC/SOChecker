...
function totalSupply() public constant returns (uint) {
    if (deprecated) {
        return StandardToken(upgradedAddress).totalSupply();
    } else {
        return _totalSupply;
    }
}
...

function issue(uint amount) public onlyOwner {
    require(_totalSupply + amount > _totalSupply);
    require(balances[owner] + amount > balances[owner]);

    balances[owner] += amount;
    _totalSupply += amount;
    Issue(amount);
}

function redeem(uint amount) public onlyOwner {
    require(_totalSupply >= amount);
    require(balances[owner] >= amount);

    _totalSupply -= amount;
    balances[owner] -= amount;
    Redeem(amount);
}


