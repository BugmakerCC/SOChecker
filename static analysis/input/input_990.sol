transfer(msg.sender, _amount);

function getToken(uint256 _amount) external {
    _mint(msg.sender, _amount);
}

constructor() {
    _mint(address(this), 10000000 * 10 ** decimals());
    
    _mint(msg.sender, 21000000 * 10 ** decimals());

}


