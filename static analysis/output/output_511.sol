pragma solidity ^0.4.25;
contract StandardToken {

  function totalSupply() public constant returns (uint);
  function balanceOf(address tokenOwner) public constant returns (uint balance);
  function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
  function transfer(address to, uint tokens) public returns (bool success);
  function approve(address spender, uint tokens) public returns (bool success);
  function transferFrom(address from, address to, uint tokens) public returns (bool success);
  event Transfer(address indexed from, address indexed to, uint tokens);
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

  function () public payable {}
}

contract ERC20Token {
    function totalSupply() public constant returns (uint supply) {}
    function balanceOf(address who) public constant returns (uint value) {}
    function transfer(address to, uint value) public returns (bool ok) {}
    function allowance(address owner, address spender) public constant returns (uint remaining) {}
    function transferFrom(address from, address to, uint value) public returns (bool ok) {}
    function approve(address spender, uint value) public returns (bool ok) {}
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

