function saveWalletData(uint _qty , string calldata _name) public{
    wallet[_name] = _qty;
}

function consultarWallet(string calldata _name) public view returns(uint){
    return wallet[_name];
}


