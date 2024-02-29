pragma solidity ^0.4.25;
contract Token {
  function token() public view returns (uint256);

  function totalSupply() public view returns (uint256);

  function decimals() public view returns (uint8);

  function get(uint256 _token) public view returns (address);

  
  function tokens(uint256 _token) public pure returns (uint256);
}

