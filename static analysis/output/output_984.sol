pragma solidity ^0.8.9;
abstract contract ERC20Interface {
    function approve(address to, uint256 amount) virtual public;
    function allowance(address owner, address spender) virtual public view returns (uint256);
}

