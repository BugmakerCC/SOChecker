pragma solidity ^0.8.9;
interface IERC20 {
  function balanceOf(address account) external view returns (uint256);
}

contract TokenHolder {
  IERC20 private token;

  constructor(address _tokenAddress) public {
    token = IERC20(_tokenAddress);
  }

  function getBalance() public view returns (uint256) {
    return token.balanceOf(address(this));
  }
}

