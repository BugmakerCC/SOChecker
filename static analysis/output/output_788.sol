pragma solidity ^0.4.25;
contract ERC721 {
    function tokenFallback(address _from, uint _value, bytes _data)
        external;
}

contract Token {
    function tokenFallback(address _from, uint _value, bytes _data)
        external {
        _from;
        _value;
        _data;
    }
}

