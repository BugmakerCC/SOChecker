contract MentalHealthCoin is ERC20, Ownable, ReentrancyGuard {

    constructor() ERC20("Mental Health Coin", "MHC") {
      _mint(msg.sender, 500000000*(10**uint256(decimals()))); 
    }
}


