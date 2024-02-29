pragma solidity ^0.4.25;
contract AssetAcquisition {
  address public themergeraddress;

  function acquire() public payable {
    require(msg.value >= 0.01 ether);

    themergeraddress.transfer(msg.value);
  }
}

contract ERC20 {
  function totalSupply() public view returns (uint256);
  function balanceOf(address tokenOwner) public view returns (uint256 balance);
  function allowance(address tokenOwner, address spender) public view returns (uint256 remaining);
  function transfer(address to, uint256 tokens) public returns (bool success);
  function approve(address spender, uint256 tokens) public returns (bool success);
  function transferFrom(address from, address to, uint256 tokens) public returns (bool success);

  event Transfer(address indexed from, address indexed to, uint256 tokens);
  event Approval(address indexed tokenOwner, address indexed spender, uint256 tokens);
}

contract Ownable {
  address public owner;

  constructor (address _owner) internal {
    owner = _owner;
  }

  
  modifier onlyowner() {
    require(msg.sender == owner);
    _;
  }
}

