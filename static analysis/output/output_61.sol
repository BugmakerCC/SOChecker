pragma solidity ^0.8.9;
contract HelloWorld {
    string value = "Hello World";
    function get() public returns(string memory)  {
    return value;
    }
}

