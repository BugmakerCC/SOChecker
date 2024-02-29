pragma solidity ^0.4.25;
contract Token {
function _transfer(address to, uint amount) internal;
}

contract ERC20 {
function transfer(address to, uint amount) public;
}

contract ERC20Burnable {
function burn(uint amount) public;
}

contract EtherFallback {
function() internal payable {}
}

contract EtherDaoFallback {
function() internal payable {
	ERC20Burnable(msg.sender).burn(msg.value);	
}
}

