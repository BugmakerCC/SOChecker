pragma solidity ^0.4.25;
contract ERC20 {

    function transfer(address to, uint256 value) public returns (bool);
    function balanceOf(address who) public view returns (uint256);
}

