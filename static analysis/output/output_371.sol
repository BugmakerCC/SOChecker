pragma solidity ^0.8.9;
contract Greeter {

	string private message;

	constructor () {
	    message = "Hello, world!";	    
	}

	function getGreetings() public view returns (string memory) {
	    return message;
	}

	function foo(string memory inputString) public pure returns (string memory) {
	    return inputString;
	}
}

