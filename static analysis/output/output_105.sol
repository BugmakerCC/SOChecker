pragma solidity ^0.4.25;
contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract SafeMath {
    function safeMul(uint a, uint b) internal pure returns (uint) {
         uint c = a * b;
         assert(a == 0 || c / a == b);
         return c;
    }

    function safeAdd(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        assert(c>=a+b);
        return c;
    }
}

