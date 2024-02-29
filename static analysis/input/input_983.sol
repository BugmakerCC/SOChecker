function deposit(address ticker,address sender,address recipient,uint256 amount
                ) 
                external payable 

await dex.deposit("0xa36085f69e2889c224210f603d836748e7dc0088", "0x5226a51522C23CcBEFd04a2d4C6c8e281eD1d680", "0xB643992c9fBcb1Cb06b6C9eb278b2ac35e6a2711", "1",
{from:accounts[0])

 

contract("Dex", (accounts) => {
  let contractOwner = null;
  let buyer = null;
  let _contract = null;


  before(async () => {
      _contract = await Dex.deployed();
      contractOwner = accounts[0];
      buyer = accounts[1];
  });

}

function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
            unchecked {
                _approve(sender, _msgSender(), currentAllowance - amount);
            }
        }  
        _transfer(sender, recipient, amount);

        return true;
    }


