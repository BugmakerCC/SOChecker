contract Pool is ERC20 {
  ...
  function deposit(uint256 amount) public payable {
    uint256 contractBalance = ERC20(stakeToken).balanceOf(address(this));
    uint256 proportion = amount * totalSupply() / contractBalance;
    ERC20(stakeToken).transferFrom(msg.sender, address(this), amount);
    _mint(msg.sender, proportion);
  }

  function withdraw() public payable {
    uint256 proportion = balanceO(msg.sender);
    uint256 contractBalance = ERC20(stakeToken).balanceOf(address(this));
    uint256 withdrawAmount = proportion * contractBalance / totalSupply();
    _burn(msg.sender, proportion);
    
    ERC20(stakeToken).transfer(msg.sender, withdrawAmount);
  }
}



