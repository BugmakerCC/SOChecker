pragma solidity ^0.4.25;
contract ERC20Interface {
    function totalSupply() public view returns (uint256);
    function balanceOf(address account) public view returns (uint256);
    function transfer(address recipient, uint256 amount) public returns (bool);
    function allowance(address owner, address spender) public view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool);
    function approve(address spender, uint256 amount) public returns (bool);
    function getAllowance(address owner, address spender) public view returns (uint256);
    function isApprovedForAll(address owner, address spender) public view returns (bool);
}

contract TokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract Transfer {
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool);
    function transfer(address recipient, uint256 amount) public returns (bool);
    function allowance(address owner, address spender) public view returns (uint256);
    function approve(address spender, uint256 amount) public returns (bool);
    function getAllowance(address owner, address spender) public view returns (uint256);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
  function () external payable {
    throw;
  }
}

