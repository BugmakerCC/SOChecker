 Note: The called function should be payable if you send value and the 
       value you send should be less than your current balance.

    constructor(uint256 _initialSupply) payable {
            balanceOf[msg.sender] = _initialSupply;
            totalSupply = _initialSupply;
    }
    


