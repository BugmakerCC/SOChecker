struct teamWallets {
    string name;
    uint256 balance;
}

mapping(address => teamWallets) public getInfoByWallet;


function setInfo(address _wall, string memory _name, uint256 _balance) public {
    getInfoByWallet[_wall].name=_name;        
    getInfoByWallet[_wall].balance=_balance;
}


