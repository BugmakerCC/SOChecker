interface IERC20 {
   function transfer(address _to, uint256 _value) external returns (bool);
   function balanceOf(address account) external view returns (uint);
}

IERC20 usdt = IERC20(address("token smart contract address in hex format"));

uint256 usdtBalance = usdt.balanceOf('your wallet address in hex format');


